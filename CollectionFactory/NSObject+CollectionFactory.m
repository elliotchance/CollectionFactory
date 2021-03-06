#import <objc/runtime.h>
#import "CollectionFactory.h"
#import "NSMutableString+CollectionFactoryPrivate.h"

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
    return [self JSONDictionaryOrError:nil];
}

- (NSDictionary *)JSONDictionaryOrError:(NSError **)error
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    @try {
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            
            id object = [self valueForKey:key];
            
            if (!object) {
                object = [NSNull null];
            }
            [dict setObject:object forKey:key];
        }
    } @catch (NSException *e) {
        // There are some special cases where valueForKey: tries to access a
        // property from a class that *is* key-value compliant but still throws
        // an exception in some cases. Another way to look at it is if
        // valueForKey: throws an exception for any reason we want to handle the
        // situation the same way.
        //
        // It would be fair to say that we just skip that property but for some
        // reason it causes an infinite recursion. Our only option is to totally
        // escape from parsing.
        NSString *description = [NSString stringWithFormat:
            @"<%@> raised '%@' and could not proceed.", [self class], e.name];
        NSDictionary *userInfo = @{
            NSLocalizedDescriptionKey: NSLocalizedString(description, nil),
            NSLocalizedFailureReasonErrorKey:
                NSLocalizedString(e.reason, nil),
        };
        
        if (error) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                         code:-1
                                     userInfo:userInfo];
        }
        
        return nil;
    } @finally {
        free(properties);
    }
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)JSONString
{
    return [self JSONStringOrError:nil];
}

- (NSString *)JSONStringOrError:(NSError **)error
{
    // This means its a subclass of NSObject that we do not have an explict way
    // to encode so we will pull the attributes from the object and encode it
    // like a dictionary.
    NSDictionary *dictionary = [self JSONDictionaryOrError:error];
    
    // `nil` is only a possible return value if JSONDictionaryOrError: failed.
    // We do not rely on the error itself because there may not be a real
    // reference to the error.
    if (dictionary == nil) {
        return nil;
    }
    
    return [dictionary JSONStringOrError:error];
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
    return [self JSONDataOrError:nil];
}

- (NSData *)JSONDataOrError:(NSError **)error
{
    NSString *string = [self JSONStringOrError:error];
    
    // `nil` is only a possible return value if JSONStringOrError: failed.
    // We do not rely on the error itself because there may not be a real
    // reference to the error.
    if (string == nil) {
        return nil;
    }
    
    return [string dataUsingEncoding:NSUTF8StringEncoding];
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

- (NSString *)prettyJSONStringWithIndentSize:(NSUInteger)indentSize
{
    return [self prettyJSONStringWithIndentSize:indentSize
                                          error:nil];
}

- (NSString *)prettyJSONStringWithIndentSize:(NSUInteger)indentSize
                                       error:(NSError **)error
{
    return [self prettyJSONStringWithIndentSize:indentSize
                                    indentLevel:0
                                          error:error];
}

// This will be overridden by the subclass to handle the formatting of the more
// specific classes. However, only some of the subclasses need to override this
// since the default fall-through is to use -[JSONString] which suffices in most
// cases.
- (NSString *)prettyJSONStringWithIndentSize:(NSUInteger)indentSize
                                 indentLevel:(NSUInteger)indentLevel
                                       error:(NSError **)error
{
    NSString *string = [self JSONStringOrError:error];
    if (string == nil) {
        return nil;
    }
    
    NSMutableString *result = [NSMutableString new];
    [result appendString:string
              indentSize:indentSize
             indentLevel:indentLevel];
    
    return result;
}

@end
