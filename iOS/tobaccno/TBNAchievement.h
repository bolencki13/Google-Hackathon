//
//  TBNAchievement.h
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UserType) {
    UserTypePatient,
    UserTypeDoctor,
};

@interface TBNAchievement : NSObject

/// ID of the achievement
@property (strong, nonatomic) NSString *achievementID;

/// Name of the achievement
@property (strong, nonatomic) NSString *name;

/// Description of the achievement
@property (strong, nonatomic) NSString *details;

/// Determines if the achievement is completed
@property (nonatomic) BOOL isCompleted;

/// ID of doctor associate with this user
@property (strong, nonatomic) UIImage *image;

/// Goal for the achievements
@property (strong, nonatomic) NSNumber *goal;

/// Custom init with dictionary
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
