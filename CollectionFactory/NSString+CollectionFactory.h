#import <Foundation/Foundation.h>

@interface NSString (CollectionFactory)

+ (NSString *)stringWithJsonString:(NSString *)jsonString;
+ (NSString *)stringWithJsonData:(NSData *)jsonData;
+ (NSString *)stringWithJsonFile:(NSString *)jsonFile;

@end
