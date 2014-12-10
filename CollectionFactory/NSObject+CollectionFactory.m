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

- (id)objectFromJson:(NSString *)json
{
    json = [json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([json isEqualToString:@"true"]) {
        return [NSNumber numberWithBool:YES];
    }
    if([json isEqualToString:@"false"]) {
        return [NSNumber numberWithBool:NO];
    }
    if([json characterAtIndex:0] == '"') {
        NSString *raw = [json substringWithRange:NSMakeRange(1, [json length] - 2)];
        return [raw stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    }
    if([json characterAtIndex:0] == '[') {
        return [NSArray arrayWithJsonString:json];
    }
    if([json characterAtIndex:0] == '{') {
        return [NSDictionary dictionaryWithJsonString:json];
    }
    if([json rangeOfString:@"."].location != NSNotFound) {
        return [NSNumber numberWithDouble:[json doubleValue]];
    }
    return [NSNumber numberWithInt:[json intValue]];
}

@end
