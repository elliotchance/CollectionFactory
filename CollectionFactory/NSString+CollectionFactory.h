#import <Cocoa/Cocoa.h>

@interface NSString (CollectionFactory)

+ (NSString *)stringWithJsonString:(NSString *)jsonString;
+ (NSString *)stringWithJsonData:(NSData *)jsonData;

@end
