#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJsonData:jsonData
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

- (NSString *)jsonString
{
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

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJsonString:jsonString
                                 mustBeOfSubclass:[NSDictionary class]
                                      makeMutable:NO];
}

+ (NSDictionary *)dictionaryWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

@end
