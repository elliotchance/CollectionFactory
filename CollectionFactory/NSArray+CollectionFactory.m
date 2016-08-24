#import "CollectionFactory.h"

@implementation NSArray (CollectionFactory)

+ (NSArray *)arrayWithJSONData:(NSData *)rawJSON
{
    return [CollectionFactory parseWithJSONData:rawJSON
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

+ (NSArray *)arrayWithJSONString:(NSString *)rawJSON
{
    return [CollectionFactory parseWithJSONString:rawJSON
                                 mustBeOfSubclass:[NSArray class]
                                      makeMutable:NO];
}

- (NSString *)JSONString
{
    if ([self count] == 0) {
        return @"[]";
    }

    // Encode each of the elements.
    NSMutableString *json = [@"[" mutableCopy];
    for (id item in self) {
        [json appendFormat:@"%@,", [item JSONString]];
    }
    
    // Replace the last "," with the closing "]".
    [json replaceCharactersInRange:NSMakeRange(json.length - 1, 1)
                        withString:@"]"];
    
    return json;
}

+ (NSArray *)arrayWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

- (NSString *)prettyJSONStringWithIndentationSize:(NSUInteger)indentationSize
{
    if ([self count] == 0) {
        return @"[\n]";
    }
    
    // Encode each of the elements.
    NSMutableString *json = [@"[\n" mutableCopy];
    for (id item in self) {
        [json appendString:[@"" stringByPaddingToLength:indentationSize
                                             withString:@" "
                                        startingAtIndex:0]];
        [json appendFormat:@"%@,\n", [item JSONString]];
    }
    
    // Replace the last "," with the closing "]".
    [json replaceCharactersInRange:NSMakeRange(json.length - 2, 2)
                        withString:@"\n]"];
    
    return json;
}

@end
