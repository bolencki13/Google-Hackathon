//
//  TBNDrag.h
//  tobaccno
//
//  Created by Andrew Boryk on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBNDrag : NSObject

/// ID of the drag
@property (strong, nonatomic) NSString *dragID;

/// Time that the drag was started
@property (strong, nonatomic) NSDate *date;

/// Duration of the drag
@property (nonatomic) CGFloat duration;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
