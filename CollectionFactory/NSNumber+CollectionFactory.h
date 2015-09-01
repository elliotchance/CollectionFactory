#import <Foundation/Foundation.h>

@interface NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJsonString:(NSString *)jsonString;
+ (NSNumber *)numberWithJsonData:(NSData *)jsonData;
+ (NSNumber *)numberWithJsonFile:(NSString *)jsonFile;

@end
