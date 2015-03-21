#import <objc/runtime.h>
#import "CollectionFactory.h"

@interface NSObject (CollectionFactoryPrivate)

+ (id)setPropertiesOfObject:(id)instance
             fromDictionary:(NSDictionary *)dictionary;

@end

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

+ (id)setPropertiesOfObject:(id)obj
             fromDictionary:(NSDictionary *)dictionary
{
    for (NSString *key in dictionary) {
        id value = [dictionary objectForKey:key];
        
        // We need to check if the property for key is a custom object to
        // recurse this operation with the new type.
        Class objectClass = [obj class];
        objc_property_t property = class_getProperty(objectClass,
                                                     [key UTF8String]);
        
        const char *propertyAttrs = property_getAttributes(property);
        if (propertyAttrs[1] == '@' && propertyAttrs[3] != 'N' && propertyAttrs[4] != 'S') {
            NSString *properties = [NSString stringWithUTF8String:propertyAttrs];
            NSRange lastQuote = [properties rangeOfString:@"\""
                                                  options:NSBackwardsSearch];
            NSRange range = NSMakeRange(3, lastQuote.location - 3);
            NSString *propertyClass = [properties substringWithRange:range];
            
            id object = [[NSClassFromString(propertyClass) alloc] init];
            value = [NSObject setPropertiesOfObject:object
                                     fromDictionary:value];
        }
        
        [obj setValue:value forProperty:key];
    }
    return obj;
}

+ (id)objectWithJsonString:(NSString *)jsonString
{
    NSDictionary *obj = [CollectionFactory parseWithJsonString:jsonString
                                              mustBeOfSubclass:nil
                                                   makeMutable:NO];
    
    // The caller class is important. If it is not NSObject then we need to
    // unroll the dictionary into a custom object.
    NSString *myClass = NSStringFromClass([self class]);
    if (![myClass isEqualToString:@"NSObject"]) {
        id object = [[NSClassFromString(myClass) alloc] init];
        return [NSObject setPropertiesOfObject:object
                                fromDictionary:obj];
    }
    
    return obj;
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

- (void)setValue:(id)value forProperty:(NSString *)property
{
    [self setValue:value forKey:property];
}

@end
