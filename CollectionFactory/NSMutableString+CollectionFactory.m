#import "CollectionFactory.h"

@implementation NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJsonString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJsonString:jsonString
                                 mustBeOfSubclass:[NSString class]
                                      makeMutable:YES];
}

+ (NSMutableString *)mutableStringWithJsonData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJsonData:jsonData
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:YES];
}

+ (NSMutableString *)mutableStringWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:YES];
}

@end
