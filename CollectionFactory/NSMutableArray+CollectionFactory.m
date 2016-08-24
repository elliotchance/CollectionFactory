#import "CollectionFactory.h"

@implementation NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJSONData:(NSData *)JSONData
{
    return [CollectionFactory parseWithJSONData:JSONData
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:YES];
}

+ (NSMutableArray *)mutableArrayWithJSONString:(NSString *)JSONString
{
    return [CollectionFactory parseWithJSONString:JSONString
                                 mustBeOfSubclass:[NSArray class]
                                      makeMutable:YES];
}

+ (NSMutableArray *)mutableArrayWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:YES];
}

@end
