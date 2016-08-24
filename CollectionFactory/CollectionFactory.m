#import "CollectionFactory.h"

@implementation CollectionFactory

+ (id)parseWithJSONString:(NSString *)jsonString
         mustBeOfSubclass:(Class)theClass
              makeMutable:(BOOL)makeMutable
{
    // NSJSONSerialization will throw an NSInvalidArgumentException if
    // `jsonData` is nil but we want to always return `nil` on error.
    if (nil == jsonString || jsonString.length == 0) {
        return nil;
    }
    
    // Trim off any surrounding spaces.
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    jsonString = [jsonString stringByTrimmingCharactersInSet:whitespace];
    
    // NSJSONSerialization can not handle single values so we wrap the "JSON" in
    // another array to make sure it is parsed and then access the element that
    // way.
    jsonString = [NSString stringWithFormat:@"[%@]", jsonString];
    
    // If the result is to be mutable we need to make sure all the containers
    // that are generated are mutaable - not just the top level.
    NSUInteger options = 0;
    if (makeMutable) {
        options = NSJSONReadingMutableContainers;
    }
    
    // Now try to decode the JSON.
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *parsed = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:options
                                                        error:nil];
    id json = [parsed objectAtIndex:0];
    
    // The result object must be a subclass of what we expect it to be,
    // otherwise this is considered a failure and we return nil. If `theClass`
    // is `nil` then we do not do type checking.
    if(nil != theClass && ![[json class] isSubclassOfClass:theClass]) {
        return nil;
    }
    
    // Everything checks out.
    return json;
}

+ (id)parseWithJSONFile:(NSString *)file
       mustBeOfSubclass:(Class)class
            makeMutable:(BOOL)makeMutable
{
    NSData *data = [NSData dataWithContentsOfFile:file];
    if (nil == data) {
        return nil;
    }
    
    return [CollectionFactory parseWithJSONData:data
                               mustBeOfSubclass:class
                                    makeMutable:makeMutable];
}

+ (id)parseWithJSONData:(NSData *)jsonData
       mustBeOfSubclass:(Class)theClass
            makeMutable:(BOOL)makeMutable
{
    if (nil == jsonData) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return [CollectionFactory parseWithJSONString:string
                                 mustBeOfSubclass:theClass
                                      makeMutable:makeMutable];
}

@end
