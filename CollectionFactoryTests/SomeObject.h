#import <Foundation/Foundation.h>

@interface SomeObject2 : NSObject

@property NSArray *arr;

@end

@interface SomeObject1 : NSObject

@property NSString *string;
@property int number;
@property SomeObject2 *obj;

@end
