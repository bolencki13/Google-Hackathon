//
//  ViewController.m
//  tobaccno
//
//  Created by Brian Olencki on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNRootViewController.h"
#import "STLBluetoothManager.h"

@interface TBNRootViewController ()

@end

@implementation TBNRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pairAction:(id)sender {
    [[STLBluetoothManager sharedManager] startScanningForDevices:^(NSArray<CBPeripheral *> *peripherals) {
        NSLog(@"Peripherals %@", peripherals);
        
        if (peripherals.count) {
            CBPeripheral *peripheral = [peripherals firstObject];
            
            if ([ABUtils notNull:peripheral]) {
                [[STLBluetoothManager sharedManager] connectToPeripheral:peripheral success:^(CBPeripheral *peripheral) {
                    
                    NSString *dataString = @"1.. 2.. 3.. testing transmission";
                    NSData *command = [dataString dataUsingEncoding:NSUTF8StringEncoding];
                    [peripheral writeValue:command forCharacteristic:[[peripheral.services objectAtIndex:0].characteristics objectAtIndex:0] type:CBCharacteristicWriteWithResponse];
                    
                } failed:^(NSError *error) {
                    NSLog(@"Error %@", error);
                }];
                
                
            }
           
        }
        
    }];
}
@end
