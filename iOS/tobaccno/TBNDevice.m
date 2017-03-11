//
//  TBNDevice.m
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNDevice.h"

@implementation TBNDevice

+ (id)currentDevice {
    static TBNDevice *sharedDevice = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDevice = [[self alloc] initSharedInstance];
        
    });
    return sharedDevice;
}

- (instancetype)initSharedInstance {
    self = [super init];

    if (self) {
        self.batteryLevel = 1.0f;
        self.liquidLevel = 1.0f;
    }
    
    return self;
}

- (NSString *)deviceID {
    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    return [oNSUUID UUIDString];
}
@end
