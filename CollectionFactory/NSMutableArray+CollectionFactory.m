#import "CollectionFactory.h"

@implementation NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJSONData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJSONData:jsonData
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:YES];
}

+ (NSMutableArray *)mutableArrayWithJSONString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJSONString:jsonString
                                 mustBeOfSubclass:[NSArray class]
                                      makeMutable:YES];
}

+ (NSMutableArray *)mutableArrayWithJSONFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJSONFile:jsonFile
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:YES];
}

@end
