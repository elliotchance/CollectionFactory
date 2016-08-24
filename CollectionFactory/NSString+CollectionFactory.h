#import <Foundation/Foundation.h>

@interface NSString (CollectionFactory)

+ (NSString *)stringWithJSONString:(NSString *)JSONString;
+ (NSString *)stringWithJSONData:(NSData *)JSONData;
+ (NSString *)stringWithJSONFile:(NSString *)pathToJSONFile;

@end
