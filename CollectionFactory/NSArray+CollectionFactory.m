#import "CollectionFactory.h"
#import "NSMutableString+CollectionFactoryPrivate.h"

@implementation NSArray (CollectionFactory)

+ (NSArray *)arrayWithJSONData:(NSData *)rawJSON
{
    return [CollectionFactory parseWithJSONData:rawJSON
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

+ (NSArray *)arrayWithJSONString:(NSString *)rawJSON
{
    return [CollectionFactory parseWithJSONString:rawJSON
                                 mustBeOfSubclass:[NSArray class]
                                      makeMutable:NO];
}

- (NSString *)JSONStringOrError:(NSError **)error
{
    if ([self count] == 0) {
        return @"[]";
    }
    
    // Encode each of the elements.
    NSMutableString *json = [@"[" mutableCopy];
    for (id item in self) {
        NSString *string = [item JSONStringOrError:error];
        if (string == nil) {
            return nil;
        }

        [json appendFormat:@"%@,", string];
    }
    
    // Replace the last "," with the closing "]".
    [json replaceCharactersInRange:NSMakeRange(json.length - 1, 1)
                        withString:@"]"];
    
    return json;
}

+ (NSArray *)arrayWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSArray class]
                                    makeMutable:NO];
}

- (NSString *)prettyJSONStringWithIndentSize:(NSUInteger)indentSize
                                 indentLevel:(NSUInteger)indentLevel
{
    NSMutableString *json = [NSMutableString new];
    NSString *item = nil;
    
    [json appendLine:@"[" indentSize:indentSize indentLevel:indentLevel];
    for (NSUInteger i = 0; i < [self count]; ++i) {
        item = [self[i] prettyJSONStringWithIndentSize:indentSize
                                           indentLevel:indentLevel + 1];
        
        [json appendString:item];
        
        if (i < [self count] - 1) {
            [json appendString:@",\n"];
        } else {
            [json appendString:@"\n"];
        }
    }
    [json appendString:@"]" indentSize:indentSize indentLevel:indentLevel];
    
    return json;
}

@end
