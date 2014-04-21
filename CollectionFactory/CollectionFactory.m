#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation CollectionFactory

+ (NSMutableDictionary *)mutableDictionaryWithJsonString:(NSString *)rawJson
{
    NSUInteger length = [rawJson length];
    NSData *data = [NSData dataWithBytes:[rawJson cStringUsingEncoding:NSStringEncodingConversionAllowLossy]
                                  length:length];
    return [CollectionFactory mutableDictionaryWithJsonData:data];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonData:(NSData *)rawJson
{
    return (NSMutableDictionary *)[self parseWithJsonData:rawJson
                                                  options:NSJSONReadingMutableContainers
                                         mustBeOfSubclass:[NSDictionary class]];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonFile:(NSString *)jsonFile
{
    NSData *rawJson = [[NSData alloc] initWithContentsOfFile:jsonFile];
    if(nil == rawJson) {
        return nil;
    }
    return [CollectionFactory mutableDictionaryWithJsonData:rawJson];
}

+ (NSArray *)arrayWithJsonData:(NSData *)rawJson
{
    return (NSArray *)[self parseWithJsonData:rawJson options:0 mustBeOfSubclass:[NSArray class]];
}

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson
{
    NSData* data = [rawJson dataUsingEncoding:NSUTF8StringEncoding];
    return [CollectionFactory arrayWithJsonData:data];
}

+ (NSDictionary *)dictionaryWithObject:(id)object
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:[object valueForKey:key] forKey:key];
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (NSString *)jsonStringWithArray:(NSArray *)array
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (id)parseWithJsonData:(NSData *)rawJson options:(NSJSONReadingOptions)options mustBeOfSubclass:(Class)class
{
    id json = [NSJSONSerialization JSONObjectWithData:rawJson options:options error:nil];
    if(![[json class] isSubclassOfClass:class]) {
        return nil;
    }
    
    return json;
}

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)rawJson
{
    return (NSDictionary *)[self parseWithJsonData:rawJson options:0 mustBeOfSubclass:[NSDictionary class]];
}

@end
