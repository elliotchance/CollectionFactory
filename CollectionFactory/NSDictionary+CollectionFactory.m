#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)JSONData
{
    return [CollectionFactory parseWithJSONData:JSONData
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

- (NSString *)JSONString
{
    if ([self count] == 0) {
        return @"{}";
    }
  
    // Encode each of the elements.
    NSMutableString *json = [@"{" mutableCopy];
    for (NSString *key in self) {
        id item = [self objectForKey:key];
        [json appendFormat:@"\"%@\":%@,", key, [item JSONString]];
    }
    
    // Replace the last "," with the closing "}".
    [json replaceCharactersInRange:NSMakeRange(json.length - 1, 1)
                        withString:@"}"];
    
    return json;
}

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)JSONString
{
    return [CollectionFactory parseWithJSONString:JSONString
                                 mustBeOfSubclass:[NSDictionary class]
                                      makeMutable:NO];
}

+ (NSDictionary *)dictionaryWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

@end
