//
//  ViewController.m
//  tobaccno
//
//  Created by Brian Olencki on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNRootViewController.h"
#import <Bean-iOS-OSX-SDK/PTDBeanManager.h>
#import "APIMethods.h"
#import "STLBluetoothManager.h"

@interface TBNRootViewController () <PTDBeanManagerDelegate, PTDBeanDelegate> {
    PTDBeanManager *mainBeanManager;
    
    PTDBean *mainBean;
    
}

@end

@implementation TBNRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mainBeanManager = [[PTDBeanManager alloc] init];
    mainBeanManager.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beanManagerDidUpdateState:(PTDBeanManager *)beanManager {
    NSLog(@"Bean Manager: %@", beanManager);
    switch (beanManager.state) {
        case BeanManagerState_PoweredOn:
            [ABUtils printString:@"Powered On"];
//            NSLog(@"Powered On");
            break;
        case BeanManagerState_PoweredOff:
            [ABUtils printString:@"Powered Off"];
//            NSLog(@"Powered Off");
            break;
        case BeanManagerState_Unsupported:
            [ABUtils printString:@"Unsupported"];
//            NSLog(@"Unsupported");
            break;
        case BeanManagerState_Unauthorized:
            [ABUtils printString:@"Unauthorized"];
//            NSLog(@"Unauthorized");
            break;
        case BeanManagerState_Unknown:
            [ABUtils printString:@"Unknown"];
//            NSLog(@"Unknown");
            break;
        case BeanManagerState_Resetting:
            [ABUtils printString:@"Resetting"];
//            NSLog(@"Resetting");
            break;
            
        default:
//            NSLog(@"Other");
            break;
    }
}

- (void)beanManager:(PTDBeanManager *)beanManager didDiscoverBean:(PTDBean *)bean error:(NSError *)error {
    [ABUtils print:bean tag:@"Did discover bean"];
//    NSLog(@"Did discover bean: %@\nNamed: %@", bean, bean.name);
    

    if ([bean.name isEqualToString:@"Kick_It"]) {
        NSError *error;
        [mainBeanManager connectToBean:bean error:&error];
        
        if ([ABUtils notNull:error]) {
            NSLog(@"Connect Error: %@", error);
        }
        
        

        
        
    }
}

- (void)beanManager:(PTDBeanManager *)beanManager didConnectBean:(PTDBean *)bean error:(NSError *)error {
//    NSLog(@"Did connect bean: %@\nNamed: %@", bean, bean.name);
    [ABUtils print:bean tag:@"Did connect bean"];
    if ([bean.name isEqualToString:@"Kick_It"]) {
//        NSLog(@"Did connect bean named: %@", bean.name);
        mainBean = bean;
        mainBean.delegate = self;
        
    }
}

- (void)beanManager:(PTDBeanManager *)beanManager didDisconnectBean:(PTDBean *)bean error:(NSError *)error {
    [ABUtils print:bean tag:@"Did disconnect bean"];
}

- (void)bean:(PTDBean *)bean serialDataReceived:(NSData *)data {
    NSLog(@"Did receive serial data: %@\nFrom bean: %@", data, bean);
    [ABUtils print:data tag:@"Did receive serial bean data"];
    
}

- (void)bean:(PTDBean *)bean bluetoothError:(BeanBluetoothError)error {
    NSLog(@"Bean Error %lu", (unsigned long)error);
}

- (IBAction)pairAction:(id)sender {
    NSError *error;
    [mainBeanManager startScanningForBeans_error:&error];
    
    
    if ([ABUtils notNull:error]) {
        NSLog(@"Scan Error: %@", error);
    }
    
//    [[STLBluetoothManager sharedManager] startScanningForDevices:^(NSArray<CBPeripheral *> *peripherals) {
//        NSLog(@"Peripherals %@", peripherals);
//        
//        if (peripherals.count) {
//            CBPeripheral *peripheral = [peripherals firstObject];
//            
//            if ([ABUtils notNull:peripheral]) {
//                [[STLBluetoothManager sharedManager] connectToPeripheral:peripheral success:^(CBPeripheral *peripheral) {
//                    NSLog(@"Connected");
//                    
////                    NSString *dataString = @"1.. 2.. 3.. testing transmission";
////                    NSData *command = [dataString dataUsingEncoding:NSUTF8StringEncoding];
////                    [peripheral writeValue:command forCharacteristic:[[peripheral.services objectAtIndex:0].characteristics objectAtIndex:0] type:CBCharacteristicWriteWithResponse];
//                    
//                } failed:^(NSError *error) {
//                    NSLog(@"Error %@", error);
//                }];
//                
//                
//            }
//           
//        }
//        
//    }];
}

@end
