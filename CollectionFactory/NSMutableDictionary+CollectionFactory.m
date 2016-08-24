#import "CollectionFactory.h"

@implementation NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJSONString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJSONString:jsonString
                                 mustBeOfSubclass:[NSMutableDictionary class]
                                      makeMutable:YES];
}

+ (NSMutableDictionary *)mutableDictionaryWithJSONData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJSONData:jsonData
                               mustBeOfSubclass:[NSMutableDictionary class]
                                    makeMutable:YES];
}

+ (NSMutableDictionary *)mutableDictionaryWithJSONFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJSONFile:jsonFile
                               mustBeOfSubclass:[NSMutableDictionary class]
                                    makeMutable:YES];
}

@end
