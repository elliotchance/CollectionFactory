#import "CollectionFactory.h"

@implementation NSArray (CollectionFactory)

+ (NSArray *)arrayWithJsonData:(NSData *)rawJson
{
    return [CollectionFactory parseWithJsonData:rawJson
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson
{
    return [CollectionFactory parseWithJsonString:rawJson
                                 mustBeOfSubclass:[NSArray class]
                                      makeMutable:NO];
}

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSArray *)arrayWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

@end
