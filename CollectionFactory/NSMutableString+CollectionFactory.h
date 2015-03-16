#import <Cocoa/Cocoa.h>

@interface NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJsonString:(NSString *)jsonString;
+ (NSMutableString *)mutableStringWithJsonData:(NSData *)jsonData;

@end
