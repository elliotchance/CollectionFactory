#import <Foundation/Foundation.h>

@interface NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJSONString:(NSString *)jsonString;
+ (NSNumber *)numberWithJSONData:(NSData *)jsonData;
+ (NSNumber *)numberWithJSONFile:(NSString *)jsonFile;

@end
