#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct {
    UInt32 m[3];
} ObjectID;

@interface MongoID : NSObject
+ (ObjectID) id;

+ (NSString *) stringWithId: (ObjectID) _id;
+ (ObjectID) idWithString:(NSString *) string;
@end
