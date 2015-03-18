#import "CollectionFactory.h"

@implementation NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJsonString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJsonString:jsonString
                                 mustBeOfSubclass:[NSMutableDictionary class]
                                      makeMutable:YES];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJsonData:jsonData
                               mustBeOfSubclass:[NSMutableDictionary class]
                                    makeMutable:YES];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSMutableDictionary class]
                                    makeMutable:YES];
}

@end
