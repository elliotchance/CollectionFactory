#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData
{
    return (NSDictionary *)[CollectionFactory parseWithJsonData:jsonData
                                                        options:0
                                               mustBeOfSubclass:[NSDictionary class]];
}

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonData
{
    NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    return [NSDictionary dictionaryWithJsonData:data];
}

@end
