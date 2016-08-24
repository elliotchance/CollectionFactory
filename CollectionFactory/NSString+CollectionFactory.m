#import "CollectionFactory.h"

@implementation NSString (CollectionFactory)

+ (NSString *)stringWithJSONString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJSONString:jsonString
                                 mustBeOfSubclass:[NSString class]
                                      makeMutable:NO];
}

+ (NSString *)stringWithJSONData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJSONData:jsonData
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:NO];
}

- (NSString *)jsonString
{
    // We use the NSJSONSerialization so we don't have to encode all the special
    // characters like \n manually.
    NSData *data = [NSJSONSerialization dataWithJSONObject:@[self]
                                                   options:0
                                                     error:nil];
    
    // Since NSJSONSerialization does not encode single values like NSString, we
    // have to wrap it in an array and chop off the geenrated square brackets.
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    NSRange range = NSMakeRange(1, string.length - 2);
    return [string substringWithRange:range];
}

+ (NSString *)stringWithJSONFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJSONFile:jsonFile
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:NO];
}

@end
