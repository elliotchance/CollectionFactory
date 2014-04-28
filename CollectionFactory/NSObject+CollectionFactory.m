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

#warning does not handle bools
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

#warning does not handle floats
#warning does not handle bools
- (id)objectFromJson:(NSString *)json
{
    if([json characterAtIndex:0] == '"') {
        NSString *raw = [json substringWithRange:NSMakeRange(1, [json length] - 2)];
        return [raw stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    }
    return [NSNumber numberWithInt:[json intValue]];
}

@end
