#import <Foundation/Foundation.h>
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

+ (id)parseWithJsonString:(NSString *)jsonString
         mustBeOfSubclass:(Class)theClass
              makeMutable:(BOOL)makeMutable;

+ (id)parseWithJsonData:(NSData *)jsonData
       mustBeOfSubclass:(Class)theClass
            makeMutable:(BOOL)makeMutable;

+ (id)parseWithJsonFile:(NSString *)file
       mustBeOfSubclass:(Class)theClass
            makeMutable:(BOOL)makeMutable;

@end
