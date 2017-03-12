//
//  TBNDragDB.h
//  tobaccno
//
//  Created by Andrew Boryk on 3/11/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import <Realm/Realm.h>

@interface TBNDragDB : RLMObject

/// ID of the drag
@property (strong, nonatomic) NSString *dragID;

/// Time that the drag was started
@property (strong, nonatomic) NSDate *date;

/// Duration of the drag
@property (strong, nonatomic) NSNumber<RLMFloat> *duration;

/// Custom init with dictionary
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
