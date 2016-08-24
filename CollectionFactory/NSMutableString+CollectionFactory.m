#import "CollectionFactory.h"

@implementation NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJSONString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJSONString:jsonString
                                 mustBeOfSubclass:[NSString class]
                                      makeMutable:YES];
}

+ (NSMutableString *)mutableStringWithJSONData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJSONData:jsonData
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:YES];
}

+ (NSMutableString *)mutableStringWithJSONFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJSONFile:jsonFile
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:YES];
}

@end
