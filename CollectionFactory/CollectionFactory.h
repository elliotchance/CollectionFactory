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
#import "NSURL+CollectionFactory.h"

@interface CollectionFactory : NSObject

+ (id)parseWithJSONString:(NSString *)JSONString
         mustBeOfSubclass:(Class)theClass
              makeMutable:(BOOL)makeMutable;

+ (id)parseWithJSONData:(NSData *)JSONData
       mustBeOfSubclass:(Class)theClass
            makeMutable:(BOOL)makeMutable;

+ (id)parseWithJSONFile:(NSString *)pathToJSONFile
       mustBeOfSubclass:(Class)theClass
            makeMutable:(BOOL)makeMutable;

@end
