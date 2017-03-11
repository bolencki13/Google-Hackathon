//
//  APIMethods.m
//  Music
//
//  Created by Andrew Boryk on 2/9/17.
//  Copyright © 2017 Andrew Boryk. All rights reserved.
//

#import "APIMethods.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import <ABUtils/ABUtils.h>
#import "OpenUDID.h"

@implementation APIMethods

//#define _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_ 1

+ (NSString *)endpoint {
    return @"https://hackathon.bolencki13.com/api/";
}

+ (NSString *)version {
    return @"v0";
}


-(void)get:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if (![ABUtils notNull:url]) {
        url = @"";
    }
    
    NSString *path = [[[APIMethods endpoint] stringByAppendingString:[APIMethods version]] stringByAppendingString:url];
    
    __block NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           @"",@"httpstatuscode",
                                           @"",@"success_data",
                                           @"",@"success_operation",
                                           @"",@"failure_operation",
                                           @"",@"failure_error",
                                           nil];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    [policy setValidatesDomainName:NO];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = policy;
    //    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    //        UIImage *image = responseObject;
    //        _profileImageView = [[UIImageView alloc] init];
    //        _profileImageView.image = image;
    //        [self addProfileImage];
    //
    //    } failure:^(NSURLSessionTask *operation, NSError *error) {
    //
    //    }];
    
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *userAgent = [manager.requestSerializer  valueForHTTPHeaderField:@"User-Agent"];
    NSString *strApplicationUUID = [self userAgent];
    
    if ([ABUtils notNull:strApplicationUUID]) {
        userAgent = strApplicationUUID;
    }
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    for(id key in header)
        [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
    
    
    [manager GET:path parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        result[@"success_data"] =  responseObject;
        
        if(block) {
            block(result, nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        
        result[@"failure_operation"] = operation;
        result[@"failure_error"] = error;
        if(block) {
            block(result, error);
        }
    }];
    
}

-(void)post:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if (![ABUtils notNull:url]) {
        url = @"";
    }
    
    NSString *path = [[[APIMethods endpoint] stringByAppendingString:[APIMethods version]] stringByAppendingString:url];
    
    __block NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           @"",@"httpstatuscode",
                                           @"",@"success_data",
                                           @"",@"success_operation",
                                           @"",@"failure_operation",
                                           @"",@"failure_error",
                                           nil];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    [policy setValidatesDomainName:NO];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = policy;
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *userAgent = [manager.requestSerializer  valueForHTTPHeaderField:@"User-Agent"];
    NSString *strApplicationUUID = [self userAgent];
    
    if ([ABUtils notNull:strApplicationUUID]) {
        userAgent = strApplicationUUID;
    }
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    NSMutableIndexSet *acceptedCodes = [[NSMutableIndexSet alloc]
                                        initWithIndexSet:manager.responseSerializer.acceptableStatusCodes];
    [acceptedCodes addIndex:404];
    [acceptedCodes addIndex:409];
    
    manager.responseSerializer.acceptableStatusCodes = [acceptedCodes copy];
    
    for(id key in header)
        [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
    
    
    [manager POST:path parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        result[@"success_data"] =  responseObject;
        //        result[@"success_operation"] = nil;
        if(block) {
            block(result, nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        
        result[@"failure_operation"] = operation;
        result[@"failure_error"] = error;
        if(block) {
            block(result, error);
        }
    }];
    
}

-(void)put:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if (![ABUtils notNull:url]) {
        url = @"";
    }
    
    NSString *path = [[[APIMethods endpoint] stringByAppendingString:[APIMethods version]]stringByAppendingString:url];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"",@"httpstatuscode",
                                   @"",@"success_data",
                                   @"",@"success_operation",
                                   @"",@"failure_operation",
                                   @"",@"failure_error",
                                   nil];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    [policy setValidatesDomainName:NO];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = policy;
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *userAgent = [manager.requestSerializer  valueForHTTPHeaderField:@"User-Agent"];
    NSString *strApplicationUUID = [self userAgent];
    
    if ([ABUtils notNull:strApplicationUUID]) {
        userAgent = strApplicationUUID;
    }
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    for(id key in header)
        [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
    
    [manager PUT:path parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        result[@"success_data"] =  responseObject;
        //        result[@"success_operation"] = nil;
        if(block) {
            block(result, nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        
        result[@"failure_operation"] = operation;
        result[@"failure_error"] = error;
        if(block) {
            block(result, error);
        }
    }];
    
}

-(void)del:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if (![ABUtils notNull:url]) {
        url = @"";
    }
    
    NSString *path = [[[APIMethods endpoint] stringByAppendingString:[APIMethods version]]stringByAppendingString:url];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"",@"httpstatuscode",
                                   @"",@"success_data",
                                   @"",@"success_operation",
                                   @"",@"failure_operation",
                                   @"",@"failure_error",
                                   nil];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    [policy setValidatesDomainName:NO];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = policy;
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *userAgent = [manager.requestSerializer  valueForHTTPHeaderField:@"User-Agent"];
    NSString *strApplicationUUID = [self userAgent];
    
    if ([ABUtils notNull:strApplicationUUID]) {
        userAgent = strApplicationUUID;
    }
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    
    for(id key in header)
        [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
    
    [manager DELETE:path parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        result[@"success_data"] =  responseObject;
        //        result[@"success_operation"] = nil;
        if(block) {
            block(result, nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        
        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
        
        result[@"failure_operation"] = operation;
        result[@"failure_error"] = error;
        if(block) {
            block(result, error);
        }
    }];
    
    
}

+ (NSDictionary *)headerLight {
    
    NSString *contentType = @"application/json";
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       contentType, @"Content-Type",
                                       nil];
    
    if ([ABUtils notNull:[OpenUDID value]]) {
        [dictionary setObject:[OpenUDID value] forKey:@"udid"];
    }
    
    return dictionary;
}

+ (NSDictionary *)headerFull {
    
    NSString *contentType = @"application/json";
    
//    if ([ABUtils notNull:[Defaults currentUser]]) {
//        if ([ABUtils notNull:[[Defaults currentUser] token]]) {
//            NSData *base64stringUser = [[[Defaults currentUser] token] dataUsingEncoding:NSUTF8StringEncoding];
//            NSString *authorization = [@"Basic " stringByAppendingString:[base64stringUser base64EncodedStringWithOptions:0]];
    
//            NSString *authorizationUser = authorization;
    
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               contentType, @"Content-Type",
//                                               authorizationUser, @"authorization",
                                               nil];
            
            if ([ABUtils notNull:[OpenUDID value]]) {
                [dictionary setObject:[OpenUDID value] forKey:@"udid"];
            }
            
            return dictionary;
//        }
//        else {
//            //        [Defaults logout];
//            return nil;
//        }
//    }
//    else {
////        [Defaults logout];
//        return nil;
//    }
}


- (NSString *) userAgent {
    NSString *version = @"noVersion";
    NSString *userID = @"noID";
    
    if ([ABUtils notNull:[APIMethods version]]) {
        version = [APIMethods version];
    }
    
    if ([ABUtils notNull:[OpenUDID value]]) {
        userID = [OpenUDID value];
    }
    
    NSString *strApplicationUUID = [NSString stringWithFormat:@" Ver [%@] UserID [%@] iOS", version, userID];
    
    return strApplicationUUID;
}
@end

