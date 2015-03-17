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
    NSArray *array = [NSObject objectWithJsonFile:jsonFile];
    if (!array) {
        return nil;
    }
    return [array mutableCopy];
}

@end
