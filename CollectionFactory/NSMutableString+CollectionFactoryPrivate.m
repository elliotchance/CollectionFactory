#import "NSMutableString+CollectionFactoryPrivate.h"

@implementation NSMutableString (CollectionFactoryPrivate)

- (void)appendLine:(NSString *)string
        indentSize:(NSUInteger)indentSize
       indentLevel:(NSUInteger)indentLevel
{
    [self appendString:string indentSize:indentSize indentLevel:indentLevel];
    [self appendString:@"\n"];
}

- (void)appendString:(NSString *)string
          indentSize:(NSUInteger)indentSize
         indentLevel:(NSUInteger)indentLevel
{
    NSString *indent = [@"" stringByPaddingToLength:indentSize
                                         withString:@" "
                                    startingAtIndex:0];
    
    for (NSUInteger i = 0; i < indentLevel; ++i) {
        [self appendString:indent];
    }
    
    [self appendString:string];
}

@end
