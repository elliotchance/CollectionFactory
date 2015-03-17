#import "CollectionFactory.h"

@implementation NSArray (CollectionFactory)

+ (NSArray *)arrayWithJsonData:(NSData *)rawJson
{
    if (!rawJson) {
        return nil;
    }
    
    return (NSArray *)[CollectionFactory parseWithJsonData:rawJson
                                                   options:0
                                          mustBeOfSubclass:[NSArray class]];
}

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson
{
    NSData* data = [rawJson dataUsingEncoding:NSUTF8StringEncoding];
    return [NSArray arrayWithJsonData:data];
}

- (NSString *)jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSArray *)arrayWithJsonFile:(NSString *)jsonFile
{
    return [NSArray arrayWithJsonData:[NSData dataWithContentsOfFile:jsonFile]];
}

@end
