#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSObject (CollectionFactory)

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:[self valueForKey:key] forKey:key];
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)jsonString
{
    if([self isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)self jsonString];
    }
    if([self isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self jsonString];
    }
    if([self isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"\"%@\"", [(NSString *)self stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]];
    }
    if([self isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)self;
        if(strcmp([number objCType], @encode(BOOL)) == 0) {
            if([number boolValue] == YES) {
                return @"true";
            }
            return @"false";
        }
        return [number description];
    }
    return [[self dictionaryValue] jsonString];
}

+ (id)objectWithJsonString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJsonString:jsonString
                                 mustBeOfSubclass:nil
                                      makeMutable:NO];
}

- (NSData *)jsonData
{
    return [[self jsonString] dataUsingEncoding:NSUTF8StringEncoding];
}

+ (id)objectWithJsonData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJsonData:jsonData
                               mustBeOfSubclass:nil
                                    makeMutable:NO];
}

+ (id)objectWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:nil
                                    makeMutable:NO];
}

@end
