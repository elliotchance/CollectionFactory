#import "NSArray+CollectionFactory.h"
#import "NSDictionary+CollectionFactory.h"
#import "NSMutableDictionary+CollectionFactory.h"
#import "NSObject+CollectionFactory.h"

@interface CollectionFactory : NSObject

+ (id)parseWithJsonData:(NSData *)rawJson
                options:(NSJSONReadingOptions)options
       mustBeOfSubclass:(Class)class;

@end
