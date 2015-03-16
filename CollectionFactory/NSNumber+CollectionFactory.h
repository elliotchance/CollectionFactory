#import <Cocoa/Cocoa.h>

@interface NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJsonString:(NSString *)jsonString;
+ (NSNumber *)numberWithJsonData:(NSData *)jsonData;

@end
