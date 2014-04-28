#import <objc/runtime.h>

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

- (NSString *)jsonValue
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
        return [(NSNumber *)self description];
    }
    return [[self dictionaryValue] jsonString];
}

- (id)objectFromJson:(NSString *)json
{
    return @123;
}

@end
