#import "CollectionFactory.h"

@implementation CollectionFactory

+ (id)parseWithJsonString:(NSString *)jsonString
         mustBeOfSubclass:(Class)theClass
              makeMutable:(BOOL)makeMutable
{
    // NSJSONSerialization will throw an NSInvalidArgumentException if
    // `jsonData` is nil but we want to always return `nil` on error.
    if (nil == jsonString) {
        return nil;
    }
    
    // Trim off any surrounding spaces.
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    jsonString = [jsonString stringByTrimmingCharactersInSet:whitespace];
    
    // NSJSONSerialization can not handle single values so we wrap the "JSON" in
    // another array to make sure it is parsed and then access the element that
    // way.
    jsonString = [NSString stringWithFormat:@"[%@]", jsonString];
    
    // Now try to decode the JSON.
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *parsed = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:0
                                                        error:nil];
    id json = [parsed objectAtIndex:0];
    
    // The result object must be a subclass of what we expect it to be,
    // otherwise this is considered a failure and we return nil. If `theClass`
    // is `nil` then we do not do type checking.
    if(nil != theClass && ![[json class] isSubclassOfClass:theClass]) {
        return nil;
    }
    
    // Everything checks out.
    if (makeMutable) {
        return [json mutableCopy];
    }
    return json;
}

+ (id)parseWithJsonFile:(NSString *)file
       mustBeOfSubclass:(Class)class
            makeMutable:(BOOL)makeMutable
{
    NSData *data = [NSData dataWithContentsOfFile:file];
    if (nil == data) {
        return nil;
    }
    
    return [CollectionFactory parseWithJsonData:data
                               mustBeOfSubclass:class
                                    makeMutable:makeMutable];
}

+ (id)parseWithJsonData:(NSData *)jsonData
       mustBeOfSubclass:(Class)theClass
            makeMutable:(BOOL)makeMutable
{
    if (nil == jsonData) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return [CollectionFactory parseWithJsonString:string
                                 mustBeOfSubclass:theClass
                                      makeMutable:makeMutable];
}

@end
