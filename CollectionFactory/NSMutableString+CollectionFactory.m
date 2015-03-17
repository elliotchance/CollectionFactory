#import "CollectionFactory.h"

@implementation NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJsonString:(NSString *)jsonString
{
    return [[NSString stringWithJsonString:jsonString] mutableCopy];
}

+ (NSMutableString *)mutableStringWithJsonData:(NSData *)jsonData
{
    return [[NSString stringWithJsonData:jsonData] mutableCopy];
}

+ (NSMutableString *)mutableStringWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithFile:jsonFile
                           mustBeOfSubclass:[NSString class]];
}

@end
