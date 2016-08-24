#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJSONData:jsonData
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

- (NSString *)jsonString
{
    if ([self count] == 0) {
        return @"{}";
    }
  
    // Encode each of the elements.
    NSMutableString *json = [@"{" mutableCopy];
    for (NSString *key in self) {
        id item = [self objectForKey:key];
        [json appendFormat:@"\"%@\":%@,", key, [item jsonString]];
    }
    
    // Replace the last "," with the closing "}".
    [json replaceCharactersInRange:NSMakeRange(json.length - 1, 1)
                        withString:@"}"];
    
    return json;
}

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJSONString:jsonString
                                 mustBeOfSubclass:[NSDictionary class]
                                      makeMutable:NO];
}

+ (NSDictionary *)dictionaryWithJSONFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJSONFile:jsonFile
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

@end
