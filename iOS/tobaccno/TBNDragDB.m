//
//  TBNDragDB.m
//  tobaccno
//
//  Created by Andrew Boryk on 3/11/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNDragDB.h"
#import <ABUtils/ABUtils.h>

@implementation TBNDragDB

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    
    self = [super init];
    
    if (self) {
        
        if ([ABUtils notNull:attributes]) {
            
            if ([ABUtils notNull:[attributes valueForKey:@"id"]]) self.dragID = [attributes valueForKey:@"id"];
        }
        
    }
    
    return self;
    
}

+ (NSString *)primaryKey {
    return @"dragID";
}

@end
