#import <objc/runtime.h>
#import "CollectionFactory.h"

@interface NSObject (CollectionFactoryPrivate)

+ (id)setPropertiesOfObject:(id)instance
             fromDictionary:(NSDictionary *)dictionary;

+ (void)setRawValue:(id)value forProperty:(NSString *)key onObject:(id)obj;

+ (BOOL)propertyAttributesDescribeAnNSClass:(const char *)attrs;

+ (NSString *)propertyClassNameFromAttributes:(const char *)attrs;

@end

@implementation NSObject (CollectionFactory)

- (NSDictionary *)JSONDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id object = [self valueForKey:key];
        if (!object) {
            object = [NSNull null];
        }
        [dict setObject:object forKey:key];
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)JSONString
{
    // This means its a subclass of NSObject that we do not have an explict way
    // to encode so we will pull the attributes from the object and encode it
    // like a dictionary.
    return [[self JSONDictionary] JSONString];
}

/**
 Crudely test if property attributes looks like it describes an NS prefixed
 class. This assumes that nobody would create their own classes with an NS
 prefix (which they shouldn't) however it does not tell the different between
 NSNull and NSANull where the latter is not part of the Foundation framework.
 */
+ (BOOL)propertyAttributesDescribeAnNSClass:(const char *)attrs
{
    // propertyAttrs will look something like:
    // T@"NSString",&,V_string
    return attrs[1] == '@' && attrs[3] != 'N' && attrs[4] != 'S';
}

/**
 Get the name of the class from the property attributes.
 */
+ (NSString *)propertyClassNameFromAttributes:(const char *)attrs
{
    NSString *properties = [NSString stringWithUTF8String:attrs];
    NSRange lastQuote = [properties rangeOfString:@"\""
                                          options:NSBackwardsSearch];
    NSRange range = NSMakeRange(3, lastQuote.location - 3);
    return [properties substringWithRange:range];
}

/**
 This is a private method to set a raw value to a property. A raw value is the
 value from the JSON that may need translating before assigning it back to the
 real object property. Ultimately this method will call setValue:forProperty:
 with the safe value for the key - this method may be overridden by the child
 class for further customisation of the property.
 */
+ (void)setRawValue:(id)value forProperty:(NSString *)key onObject:(id)obj
{
    // Dictionaries cannot contain a nil value so we use the standard NSNull
    // object as a placeholder. This also gives us the advantage of knowing the
    // difference between a key that is not set and one that is actually null.
    if ([value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    
    // We need to check if the property for key is a custom object to recurse
    // this operation with the new type.
    Class objectClass = [obj class];
    objc_property_t property = class_getProperty(objectClass,
                                                 [key UTF8String]);
    
    if (property == 0) {
        return;
    }
    const char *propertyAttrs = property_getAttributes(property);
    if ([NSObject propertyAttributesDescribeAnNSClass:propertyAttrs]) {
        NSString *class = [NSObject propertyClassNameFromAttributes:propertyAttrs];
        
        id object = [[NSClassFromString(class) alloc] init];
        value = [NSObject setPropertiesOfObject:object
                                 fromDictionary:value];
    }
    
    [obj setValue:value forProperty:key];
}

+ (id)setPropertiesOfObject:(id)obj
             fromDictionary:(NSDictionary *)dictionary
{
    for (NSString *key in dictionary) {
        id value = [dictionary objectForKey:key];
        [self setRawValue:value forProperty:key onObject:obj];
    }
    return obj;
}

+ (id)objectWithJSONString:(NSString *)JSONString
{
    NSDictionary *obj = [CollectionFactory parseWithJSONString:JSONString
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

- (NSData *)JSONData
{
    return [[self JSONString] dataUsingEncoding:NSUTF8StringEncoding];
}

+ (id)objectWithJSONData:(NSData *)JSONData
{
    return [CollectionFactory parseWithJSONData:JSONData
                               mustBeOfSubclass:nil
                                    makeMutable:NO];
}

+ (id)objectWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:nil
                                    makeMutable:NO];
}

/**
 This can be overridden by your subclass if you need custom logic for unpacking
 properties.
 */
- (void)setValue:(id)value forProperty:(NSString *)property
{
    [self setValue:value forKey:property];
}

// This will be overridden by the subclass to handle the formatting of the more
// specific class. However, only some of the subclasses need to override this
// since the default fall-though is to use -[JSONString] which suffices in most
// cases.
- (NSString *)prettyJSONStringWithIndentationSize:(NSUInteger)indentationSize
{
    return [self JSONString];
}

@end
