//
//  APIMethods.h
//  Music
//
//  Created by Andrew Boryk on 2/9/17.
//  Copyright © 2017 Andrew Boryk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIMethods : NSObject

/// Endpoint for the API
+ (NSString *)endpoint;

/// Version of the API
+ (NSString *)version;

/// GET request for API
-(void)get:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block;

/// POST request for API
-(void)post:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block;

/// PUT request for API
-(void)put:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block;

/// DEL request for API
-(void)del:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block;

/// Full header for request
+ (NSDictionary *)headerFull;

/// Header with less token information
+ (NSDictionary *)headerLight;

@end
