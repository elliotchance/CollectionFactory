#import "CollectionFactory.h"

@implementation NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJSONString:(NSString *)JSONString
{
    return [CollectionFactory parseWithJSONString:JSONString
                                 mustBeOfSubclass:[NSMutableDictionary class]
                                      makeMutable:YES];
}

+ (NSMutableDictionary *)mutableDictionaryWithJSONData:(NSData *)JSONData
{
    return [CollectionFactory parseWithJSONData:JSONData
                               mustBeOfSubclass:[NSMutableDictionary class]
                                    makeMutable:YES];
}

+ (NSMutableDictionary *)mutableDictionaryWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSMutableDictionary class]
                                    makeMutable:YES];
}

@end
