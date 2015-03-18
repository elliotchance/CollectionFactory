#import "CollectionFactory.h"

@implementation NSArray (CollectionFactory)

+ (NSArray *)arrayWithJsonData:(NSData *)rawJson
{
    return [CollectionFactory parseWithJsonData:rawJson
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson
{
    return [CollectionFactory parseWithJsonString:rawJson
                                 mustBeOfSubclass:[NSArray class]
                                      makeMutable:NO];
}

- (NSString *)jsonString
{
    // Encode each of the elements.
    NSMutableString *json = [@"[" mutableCopy];
    for (id item in self) {
        [json appendFormat:@"%@,", [item jsonString]];
    }
    
    // Replace the last "," with the closing "]".
    [json replaceCharactersInRange:NSMakeRange(json.length - 1, 1)
                        withString:@"]"];
    
    return json;
}

+ (NSArray *)arrayWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

@end
