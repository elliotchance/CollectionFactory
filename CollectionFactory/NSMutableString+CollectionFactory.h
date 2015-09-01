#import <Foundation/Foundation.h>

@interface NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJsonString:(NSString *)jsonString;
+ (NSMutableString *)mutableStringWithJsonData:(NSData *)jsonData;
+ (NSMutableString *)mutableStringWithJsonFile:(NSString *)jsonFile;

@end
