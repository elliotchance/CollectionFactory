#import <objc/runtime.h>
#import "CollectionFactory.h"
#import "NSMutableString+CollectionFactoryPrivate.h"

@implementation NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)JSONData
{
    return [CollectionFactory parseWithJSONData:JSONData
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

- (NSString *)JSONStringOrError:(NSError **)error
{
    if ([self count] == 0) {
        return @"{}";
    }
  
    // Encode each of the elements.
    NSMutableString *json = [@"{" mutableCopy];
    for (NSString *key in self) {
        id item = [self objectForKey:key];

        NSString *string = [item JSONStringOrError:error];
        if (string == nil) {
            return nil;
        }

        [json appendFormat:@"\"%@\":%@,", key, string];
    }
    
    // Replace the last "," with the closing "}".
    [json replaceCharactersInRange:NSMakeRange(json.length - 1, 1)
                        withString:@"}"];
    
    return json;
}

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)JSONString
{
    return [CollectionFactory parseWithJSONString:JSONString
                                 mustBeOfSubclass:[NSDictionary class]
                                      makeMutable:NO];
}

+ (NSDictionary *)dictionaryWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSDictionary class]
                                    makeMutable:NO];
}

- (NSString *)prettyJSONStringWithIndentSize:(NSUInteger)indentSize
                                 indentLevel:(NSUInteger)indentLevel
                                       error:(NSError **)error
{
    NSMutableString *json = [NSMutableString new];
    NSString *item = nil;
    NSArray *keys = [self allKeys];
    
    [json appendLine:@"{" indentSize:indentSize indentLevel:indentLevel];
    for (NSUInteger i = 0; i < [keys count]; ++i) {
        item = [self[keys[i]] prettyJSONStringWithIndentSize:indentSize
                                                 indentLevel:indentLevel + 1
                                                       error:error];
        
        // The `item` will have the indent level on every line, but since we
        // start the nested item on the same line as the key we need to trim the
        // initial spaces off.
        item = [item stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceCharacterSet]];
        
        [json appendString:@""
                indentSize:indentSize
               indentLevel:indentLevel + 1];
        [json appendFormat:@"\"%@\": %@", keys[i], item];
        
        if (i < [keys count] - 1) {
            [json appendString:@",\n"];
        } else {
            [json appendString:@"\n"];
        }
    }
    [json appendString:@"}" indentSize:indentSize indentLevel:indentLevel];
    
    return json;
}

@end
