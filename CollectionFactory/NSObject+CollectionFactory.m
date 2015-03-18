#import <objc/runtime.h>
#import "CollectionFactory.h"

@implementation NSObject (CollectionFactory)

- (NSDictionary *)jsonDictionary
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
    // This means its a subclass of NSObject that we do not have an explict way
    // to encode so we will pull the attributes from the object and encode it
    // like a dictionary.
    return [[self jsonDictionary] jsonString];
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
