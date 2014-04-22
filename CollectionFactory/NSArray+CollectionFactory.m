#import "NSArray+CollectionFactory.h"

@implementation NSArray (CollectionFactory)

+ (NSArray *)arrayWithJsonData:(NSData *)rawJson
{
    return (NSArray *)[CollectionFactory parseWithJsonData:rawJson
                                                   options:0
                                          mustBeOfSubclass:[NSArray class]];
}

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson
{
    NSData* data = [rawJson dataUsingEncoding:NSUTF8StringEncoding];
    return [NSArray arrayWithJsonData:data];
}

@end
