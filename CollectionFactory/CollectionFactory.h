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

+ (BOOL)isJsonString:(NSString *)string;

+ (id)parseWithJsonData:(NSData *)jsonData
                options:(NSJSONReadingOptions)options
       mustBeOfSubclass:(Class)class;

+ (id)parseWithFile:(NSString *)file
   mustBeOfSubclass:(Class)class;

@end
