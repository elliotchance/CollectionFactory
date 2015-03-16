#import "NSString+CollectionFactory.h"
#import "NSMutableString+CollectionFactory.h"

@implementation NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJsonString:(NSString *)jsonString
{
    return [[NSString stringWithJsonString:jsonString] mutableCopy];
}

+ (NSMutableString *)mutableStringWithJsonData:(NSData *)jsonData
{
    return [[NSString stringWithJsonData:jsonData] mutableCopy];
}

@end
