//
//  TBNUser.h
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBNUser : NSObject

/// ID of the user
@property (strong, nonatomic) NSString *userID;

/// Name of the user
@property (strong, nonatomic) NSString *name;

/// Determines if the user is a doctor
@property (nonatomic) BOOL isDoctor;

/// ID of doctor associate with this user
@property (strong, nonatomic) NSString *doctorID;

/// Array of achievements the user has collected
@property (strong, nonatomic) NSMutableArray *achievements;


@end
