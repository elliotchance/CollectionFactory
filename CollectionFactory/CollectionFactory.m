#import "CollectionFactory.h"

@implementation CollectionFactory

+ (BOOL)isJsonString:(NSString *)string
{
    NSRegularExpression *regex;
    regex = [NSRegularExpression regularExpressionWithPattern:@"^\".*\"$"
                                                      options:0
                                                        error:nil];
    return [regex firstMatchInString:string
                             options:0
                               range:NSMakeRange(0, string.length)] != nil;
}

+ (id)parseWithJsonData:(NSData *)jsonData
                options:(NSJSONReadingOptions)options
       mustBeOfSubclass:(Class)class
{
    // NSJSONSerialization will throw an NSInvalidArgumentException if
    // `jsonData` is nil but we want to always return `nil` on error.
    if (nil == jsonData) {
        return nil;
    }
    
    // Trim off any surrounding spaces.
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    jsonString = [jsonString stringByTrimmingCharactersInSet:whitespace];
    
    // NSJSONSerialization can not handle single values so we wrap the "JSON" in
    // another array to make sure it is parsed and then access the element that
    // way.
    jsonString = [NSString stringWithFormat:@"[%@]", jsonString];
    
    // Now try to decode the JSON.
    jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *parsed = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:options
                                                        error:nil];
    id json = [parsed objectAtIndex:0];
    
    // The result object must be a subclass of what we expect it to be,
    // otherwise this is considered a failure and we return nil.
    if(![[json class] isSubclassOfClass:class]) {
        return nil;
    }
    
    // Everything checks out.
    return json;
}

+ (id)parseWithFile:(NSString *)file
   mustBeOfSubclass:(Class)class
{
    NSData *data = [NSData dataWithContentsOfFile:file];
    return [CollectionFactory parseWithJsonData:data
                                        options:0
                               mustBeOfSubclass:class];
}

@end
