#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)rawJson
{
    return (NSDictionary *)[CollectionFactory parseWithJsonData:rawJson
                                                        options:0
                                               mustBeOfSubclass:[NSDictionary class]];
}

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)rawJson
{
    NSData* data = [rawJson dataUsingEncoding:NSUTF8StringEncoding];
    return [NSDictionary dictionaryWithJsonData:data];
}

@end
