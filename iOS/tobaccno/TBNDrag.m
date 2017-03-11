//
//  TBNDrag.m
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNDrag.h"
#import <ABUtils/ABUtils.h>
#import "APIMethods.h"

@implementation TBNDrag

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    
    self = [super init];
    
    if (self) {
        
        if ([ABUtils notNull:attributes]) {
            
            if ([ABUtils notNull:[attributes valueForKey:@"id"]]) self.dragID = [attributes valueForKey:@"id"];
        }
        
    }
    
    return self;

}
+ (void)postDrag:(NSDictionary*)params completion:(void(^)(TBNDrag *drag, NSError *error ))block{
    
    NSString *url = @"/drags/register";
    
    APIMethods *x = [[APIMethods alloc] init];
    [x post:url setHeader:[APIMethods headerFull] setParameter:params completion:^(NSDictionary *response, NSError *error) {
        [ABUtils print:response tag:@"Post Drag Info"];
        if (!error) {
            NSDictionary *data  = [response valueForKey:@"success_data"];
            TBNDrag *drag = [[TBNDrag alloc] initWithAttributes:data];
            block(drag, error);
        }
        else {
            block(nil, error);
        }
    }];

}
//No need for a get method, no drags are being posted to the phone
@end
