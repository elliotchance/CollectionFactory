#import "CollectionFactory.h"

@implementation NSString (CollectionFactory)

+ (NSString *)stringWithJsonString:(NSString *)jsonString
{
    if (!jsonString) {
        return nil;
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\".*\"$"
                                                                           options:0
                                                                             error:nil];
    if (![regex firstMatchInString:jsonString
                           options:0
                             range:NSMakeRange(0, jsonString.length)]) {
        return nil;
    }
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\"
                                                       withString:@""];
    NSRange range = NSMakeRange(1, [jsonString length] - 2);
    return [jsonString substringWithRange:range];
}

+ (NSString *)stringWithJsonData:(NSData *)jsonData
{
    NSString *string = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return [NSString stringWithJsonString:string];
}

- (NSString *)jsonString
{
    NSString *escaped = [self stringByReplacingOccurrencesOfString:@"\""
                                                        withString:@"\\\""];
    return [NSString stringWithFormat:@"\"%@\"", escaped];
}

+ (NSString *)stringWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithFile:jsonFile
                           mustBeOfSubclass:[NSString class]];
}

@end
