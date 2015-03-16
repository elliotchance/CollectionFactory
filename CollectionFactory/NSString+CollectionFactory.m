#import "NSString+CollectionFactory.h"
#import "NSObject+CollectionFactory.h"

@implementation NSString (CollectionFactory)

+ (NSString *)stringWithJsonString:(NSString *)jsonString
{
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

- (NSData *)jsonData
{
    return [[self jsonString] dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)jsonString
{
    NSString *escaped = [self stringByReplacingOccurrencesOfString:@"\""
                                                        withString:@"\\\""];
    return [NSString stringWithFormat:@"\"%@\"", escaped];
}

@end
