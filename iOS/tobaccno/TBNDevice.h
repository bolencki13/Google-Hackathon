//
//  TBNDevice.h
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBNDevice : NSObject

/// Current device of the user, shared instance
+ (id)currentDevice;

/// ID of the device
@property (strong, nonatomic) NSString *deviceID;

/// Level of battery for the device (0.0 - 1.0)
@property (nonatomic) CGFloat batteryLevel;

/// Level of liquid for the device (0.0 - 1.0)
@property (nonatomic) CGFloat liquidLevel;

/// Custom init with dictionary
//- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
