#import <Foundation/Foundation.h>

@interface NSString (CollectionFactory)

+ (NSString *)stringWithJSONString:(NSString *)jsonString;
+ (NSString *)stringWithJSONData:(NSData *)jsonData;
+ (NSString *)stringWithJSONFile:(NSString *)jsonFile;

@end
