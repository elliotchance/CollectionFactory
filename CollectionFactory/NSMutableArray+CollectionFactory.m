#import "CollectionFactory.h"

@implementation NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJsonData:(NSData *)jsonData
{
    return [[NSArray arrayWithJsonData:jsonData] mutableCopy];
}

+ (NSMutableArray *)mutableArrayWithJsonString:(NSString *)jsonString
{
    return [[NSArray arrayWithJsonString:jsonString] mutableCopy];
}

+ (NSMutableArray *)mutableArrayWithJsonFile:(NSString *)jsonFile
{
    return nil;
}

@end
