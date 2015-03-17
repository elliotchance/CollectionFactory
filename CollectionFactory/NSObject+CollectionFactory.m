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
    if (nil == jsonString) {
        return nil;
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([jsonString isEqualToString:@"true"]) {
        return [NSNumber numberWithBool:YES];
    }
    if([jsonString isEqualToString:@"false"]) {
        return [NSNumber numberWithBool:NO];
    }
    if([jsonString characterAtIndex:0] == '"') {
        NSString *raw = [jsonString substringWithRange:NSMakeRange(1, [jsonString length] - 2)];
        return [raw stringByReplacingOccurrencesOfString:@"\\\""
                                              withString:@"\""];
    }
    if([jsonString characterAtIndex:0] == '[') {
        return [NSArray arrayWithJsonString:jsonString];
    }
    if([jsonString characterAtIndex:0] == '{') {
        return [NSDictionary dictionaryWithJsonString:jsonString];
    }
    if([jsonString rangeOfString:@"."].location != NSNotFound) {
        return [NSNumber numberWithDouble:[jsonString doubleValue]];
    }
    return [NSNumber numberWithInt:[jsonString intValue]];
}

- (NSData *)jsonData
{
    return [[self jsonString] dataUsingEncoding:NSUTF8StringEncoding];
}

+ (id)objectWithJsonData:(NSData *)jsonData
{
    if (nil == jsonData) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return [NSObject objectWithJsonString:string];
}

@end
