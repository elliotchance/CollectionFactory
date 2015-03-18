#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJsonData:jsonData
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJsonString:jsonString
                                 mustBeOfSubclass:[NSDictionary class]
                                      makeMutable:NO];
}

+ (NSDictionary *)dictionaryWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

@end
