#import <Foundation/Foundation.h>

@interface NSMutableString (CollectionFactoryPrivate)

// When building pretty JSON this provides an easier way to append indentation
// (of spaces).
- (void)appendLine:(NSString *)string
        indentSize:(NSUInteger)indentSize
       indentLevel:(NSUInteger)indentLevel;

- (void)appendString:(NSString *)string
          indentSize:(NSUInteger)indentSize
         indentLevel:(NSUInteger)indentLevel;

@end
