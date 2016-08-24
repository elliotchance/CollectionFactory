#import <Foundation/Foundation.h>

@interface NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJSONString:(NSString *)JSONString;
+ (NSNumber *)numberWithJSONData:(NSData *)JSONData;
+ (NSNumber *)numberWithJSONFile:(NSString *)pathToJSONFile;

@end
