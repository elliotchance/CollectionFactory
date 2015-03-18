#import "CollectionFactory.h"

@implementation NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJsonData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJsonData:jsonData
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:YES];
}

+ (NSMutableArray *)mutableArrayWithJsonString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJsonString:jsonString
                                 mustBeOfSubclass:[NSArray class]
                                      makeMutable:YES];
}

+ (NSMutableArray *)mutableArrayWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:YES];
}

@end
