//
//  TBNAchievement.m
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNAchievement.h"
#import <ABUtils/ABUtils.h>
#import "APIMethods.h"


@implementation TBNAchievement

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    
    if (self) {
        
        if ([ABUtils notNull:attributes]) {
            
            if ([ABUtils notNull:[attributes valueForKey:@"id"]]) self.achievementID = [attributes valueForKey:@"id"];
        }
        
    }
    
    return self;
}

+ (void)getAllAchievements: (NSDictionary*)params completion:(void(^) (TBNAchievement *achievement, NSError *error))block{
    
    NSString *url = @"/achievements";
    //if ([ABUtils notNull:[params valueForKey:@"userID"]]) {
    //  url = [@"/achievements" stringByAppendingString:[params valueForKey:@"userID"]];
    
    APIMethods *x = [[APIMethods alloc] init];
    [x get:url setHeader:[APIMethods headerFull] setParameter:nil completion:^(NSDictionary *response, NSError *error) {
        [ABUtils print:response tag:@"Get Profile Response"];
        if (!error) {
            NSDictionary *data  = [response valueForKey:@"success_data"];
            TBNAchievement *achievement = [[TBNAchievement alloc] initWithAttributes:data];
            block(achievement, error);
        }
        else {
            block(nil, error);
        }
    }];
}
+(void)postAchievment: (NSDictionary*)param completion:(void(^)(TBNAchievement *achievment, NSError *error))block{
    
    NSString *url = @"/achievements/register";
    //if ([ABUtils notNull:[params valueForKey:@"userID"]]) {
    //  url = [@"/achievements" stringByAppendingString:[params valueForKey:@"userID"]];
    
    
    
    APIMethods *x = [[APIMethods alloc] init];
    [x post:url setHeader:[APIMethods headerFull] setParameter:param completion:^(NSDictionary *response, NSError *error) {
        [ABUtils print:response tag:@"Post Drag Info"];
        if (!error) {
            NSDictionary *data  = [response valueForKey:@"success_data"];
            TBNAchievement *achievement = [[TBNAchievement alloc] initWithAttributes:data];
            block(achievement, error);
        }
        else {
            block(nil, error);
        }
    }];
}
+ (void)getAchievement: (NSDictionary*)params completion:(void(^) (TBNAchievement *achievement, NSError *error))block{
    
    NSString *url = @"/achievements/info/";
    if ([ABUtils notNull:[params valueForKey:@"achievementID"]]) {
        url = [@"/achievements/info/" stringByAppendingString:[params valueForKey:@"achievementID"]];
        
        APIMethods *x = [[APIMethods alloc] init];
        [x get:url setHeader:[APIMethods headerFull] setParameter:nil completion:^(NSDictionary *response, NSError *error) {
            [ABUtils print:response tag:@"Get Profile Response"];
            if (!error) {
                NSDictionary *data  = [response valueForKey:@"success_data"];
                TBNAchievement *achievement = [[TBNAchievement alloc] initWithAttributes:data];
                block(achievement, error);
            }
            else {
                block(nil, error);
            }
        }];
    }
}

@end
