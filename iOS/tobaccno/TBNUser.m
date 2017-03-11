//
//  TBNUser.m
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNUser.h"
#import <ABUtils/ABUtils.h>
#import "APIMethods.h"

@implementation TBNUser

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    
    if (self) {
        
        if ([ABUtils notNull:attributes]) {
            
            if ([ABUtils notNull:[attributes valueForKey:@"id"]]) self.userID = [attributes valueForKey:@"id"];
            if ([ABUtils notNull:[attributes valueForKey:@"name"]]) self.name = [attributes valueForKey:@"name"];
            if ([ABUtils notNull:[attributes valueForKey:@"doctorID"]]) self.doctorID = [attributes valueForKey:@"doctorID"];
            if ([ABUtils notNull:[attributes valueForKey:@"achievements"]]) self.achievements = [attributes valueForKey:@"achievements"];
            if ([ABUtils notNull:[attributes valueForKey:@"completed"]]) self.isDoctor = [ABUtils boolValue:[attributes valueForKey:@"completed"]];

        }
        
    }
    
    return self;
}

+ (void)getProfile:(NSDictionary *)params completion:(void (^)(TBNUser *user, NSError *error))block {
    
    
    NSString *url = @"/patients/info/";
    if ([ABUtils notNull:[params valueForKey:@"userID"]]) {
        url = [@"/patients/info/" stringByAppendingString:[params valueForKey:@"userID"]];
    
    APIMethods *x = [[APIMethods alloc] init];
    [x get:url setHeader:[APIMethods headerFull] setParameter:nil completion:^(NSDictionary *response, NSError *error) {
        [ABUtils print:response tag:@"Get Profile Response"];
        if (!error) {
            NSDictionary *data  = [response valueForKey:@"success_data"];
            TBNUser *user = [[TBNUser alloc] initWithAttributes:data];
            block(user, error);
        }
        else {
            block(nil, error);
        }
    }];
}
}
+ (void)updateProfile:(NSDictionary *)params completion:(void (^)(TBNUser * user, NSError *error))block{
    
    NSString *url = @"/patients/info/";
    if ([ABUtils notNull:[params valueForKey:@"userID"]]) {
        url = [@"/patients/info" stringByAppendingString:[params valueForKey:@"userID"]];
    }
    APIMethods *x = [[APIMethods alloc]init];
    
    /*parameters for the post should be 
     data =  
     {
        { userid : blah },      required
     
            {
     name : @"";               at least one required or nothing updated
     doctorID : @"";
     achiechvments : (array)
     nicotineLevel : float;
     }*/
    [x put:url setHeader:[APIMethods headerFull] setParameter:params completion:^(NSDictionary *response, NSError *error){
        [ABUtils print:response tag:@"Get Profile Update Response"];
        
        if (!error) {
            NSDictionary *data  = [response valueForKey:@"success_data"];
            TBNUser *user = [[TBNUser alloc] initWithAttributes:data];
            block(user, error);
        }
        else {
            block(nil, error);
        }
    }];
}
+ (void)createUser:(NSDictionary *)params completion:(void(^)(TBNUser *user, NSError *error))block{
    
    
    NSString *url = @"/patients/register";
    if ([ABUtils notNull:[params valueForKey:@"userID"]]) {
        NSLog(@"User already created");
        return;
    }else{
        
    }
}

@end
