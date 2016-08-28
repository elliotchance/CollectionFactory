#import "CollectionFactory.h"

@implementation NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJSONString:(NSString *)JSONString
{
    return [CollectionFactory parseWithJSONString:JSONString
                                 mustBeOfSubclass:[NSString class]
                                      makeMutable:YES];
}

+ (NSMutableString *)mutableStringWithJSONData:(NSData *)JSONData
{
    return [CollectionFactory parseWithJSONData:JSONData
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:YES];
}

+ (NSMutableString *)mutableStringWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSString class]
                                    makeMutable:YES];
}

@end
