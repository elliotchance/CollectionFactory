#import "NSArray+CollectionFactory.h"
#import "NSDictionary+CollectionFactory.h"
#import "NSMutableDictionary+CollectionFactory.h"
#import "NSObject+CollectionFactory.h"
#import "NSNumber+CollectionFactory.h"
#import "NSString+CollectionFactory.h"
#import "NSMutableString+CollectionFactory.h"
#import "NSMutableArray+CollectionFactory.h"
#import "NSNull+CollectionFactory.h"

@interface CollectionFactory : NSObject

+ (id)parseWithJsonData:(NSData *)jsonData
                options:(NSJSONReadingOptions)options
       mustBeOfSubclass:(Class)class;

@end
