//
//  STLBluetoothManager.m
//  StarLight
//
//  Created by Brian Olencki on 12/22/16.
//  Copyright © 2016 Brian Olencki. All rights reserved.
//

#import "STLBluetoothManager.h"

#define BLUE_BEAN_UUID (@"DB09DF56-5F04-F1F0-CF79-0C1C3E9BFE22")
#define CENTRAL_MANAGER_UUID (@"A495FF10-C5B1-4B44-B512-1370F02D74DE")
#define PERIPHERAL_UUID (@"A495FF11-C5B1-4B44-B512-1370F02D74DE")

@interface STLBluetoothManager () <CBCentralManagerDelegate, CBPeripheralDelegate> {
    NSMutableArray<CBPeripheral*> *aryPeripheral;
}
@property (nonatomic, readonly) BOOL shouldScan;
@property (nonatomic, copy) STLDeviceFailed failed;
@property (nonatomic, copy) STLDeviceDiscovery discovery;
@property (nonatomic, copy) STLDeviceConnectionSuccess connectionSuccess;
@property (nonatomic, retain, readonly) CBCentralManager *centralManager;
@end

@implementation STLBluetoothManager
+ (STLBluetoothManager *)sharedManager {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _shouldScan = NO;
        aryPeripheral = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Collection
- (NSArray<CBPeripheral *> *)peripherals {
    return aryPeripheral;
}
- (BOOL)containsPeripheral:(CBPeripheral*)peripheral {
    BOOL contains = NO;
    for (CBPeripheral *_peripheral in aryPeripheral) {
        if ([_peripheral.name isEqualToString:_peripheral.name]) contains = YES;
    }
    return contains;
}

#pragma mark - Actions 
- (void)startScanningForDevices:(STLDeviceDiscovery)block {
    self.discovery = block;
    if (_centralManager) [self stopScanning];
    _shouldScan = YES;
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}
- (void)stopScanning {
    _shouldScan = NO;
    [_centralManager stopScan];
    _centralManager = nil;
}
- (void)connectToPeripheral:(CBPeripheral *)peripheral success:(STLDeviceConnectionSuccess)success failed:(STLDeviceFailed)failed {
    if (peripheral) {
        self.connectionSuccess = success;
        self.failed = failed;
        _connectedPeripheral = nil;
        [_centralManager connectPeripheral:peripheral options:@{
                                                                CBConnectPeripheralOptionNotifyOnNotificationKey : @YES
                                                                }];
    }
}
- (void)disconnnectFromPeripheral:(CBPeripheral*)peripheral {
    [self.centralManager cancelPeripheralConnection:peripheral];
    _connectedPeripheral = nil;
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    if (localName > 0) {
        if (![self containsPeripheral:peripheral]) {
            [aryPeripheral addObject:peripheral];
            if (self.discovery) {
                self.discovery([self peripherals]);
            }
        }
    }
}
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBManagerStatePoweredOn: {
            if (_shouldScan) {
                [_centralManager scanForPeripheralsWithServices:@[
//                                                                   [CBUUID UUIDWithString:BLUE_BEAN_UUID],
                                                                  ] options:nil];
            }
        } break;
            
        default:
            break;
    }
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    _connectedPeripheral = peripheral;
    _connectedPeripheral.delegate = self;
    
    if (_connectedPeripheral.services.count > 0) {
        [self peripheral:_connectedPeripheral didDiscoverServices:nil];
    } else {
        [_connectedPeripheral discoverServices:@[
                                       [CBUUID UUIDWithString:CENTRAL_MANAGER_UUID]
                                       ]];
    }
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    if (self.failed) self.failed(error);
}


#pragma mark - CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    _connectedPeripheral = peripheral;
    NSLog(@"Connected peripheral %@", _connectedPeripheral);
    
    for (CBService *service in peripheral.services) {
        NSLog(@"Service: %@",service.UUID.UUIDString);
    }
    
    if (_connectedPeripheral.services.count > 0) {
        [_connectedPeripheral discoverCharacteristics:@[
                                                        [CBUUID UUIDWithString:PERIPHERAL_UUID]
                                                        ] forService:[_connectedPeripheral.services objectAtIndex:0]];
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    _connectedPeripheral = peripheral;
  
    if (self.connectionSuccess) self.connectionSuccess(_connectedPeripheral);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"Peripheral %@", peripheral);
}
@end
