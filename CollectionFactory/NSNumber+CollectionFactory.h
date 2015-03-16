#import <Cocoa/Cocoa.h>

@interface NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJsonString:(NSString *)jsonString;

@end
