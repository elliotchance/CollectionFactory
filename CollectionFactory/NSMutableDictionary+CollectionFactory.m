#import "CollectionFactory.h"

@implementation NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJsonString:(NSString *)jsonString
{
    if(nil == jsonString) {
        return nil;
    }
    
    NSUInteger length = [jsonString length];
    NSData *data = [NSData dataWithBytes:[jsonString cStringUsingEncoding:NSStringEncodingConversionAllowLossy]
                                  length:length];
    return [NSMutableDictionary mutableDictionaryWithJsonData:data];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonData:(NSData *)jsonData
{
    return (NSMutableDictionary *)[CollectionFactory parseWithJsonData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                      mustBeOfSubclass:[NSDictionary class]];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonFile:(NSString *)jsonFile
{
    NSData *rawJson = [[NSData alloc] initWithContentsOfFile:jsonFile];
    if(nil == rawJson) {
        return nil;
    }
    return [NSMutableDictionary mutableDictionaryWithJsonData:rawJson];
}

@end
