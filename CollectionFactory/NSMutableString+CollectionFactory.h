#import <Foundation/Foundation.h>

@interface NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJSONString:(NSString *)jsonString;
+ (NSMutableString *)mutableStringWithJSONData:(NSData *)jsonData;
+ (NSMutableString *)mutableStringWithJSONFile:(NSString *)jsonFile;

@end
