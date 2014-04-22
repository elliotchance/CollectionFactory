#import <objc/runtime.h>

@implementation NSDictionary (CollectionFactory)

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

@end
