#import <Foundation/Foundation.h>

@interface NSMutableString (CollectionFactory)

+ (NSMutableString *)mutableStringWithJSONString:(NSString *)JSONString;
+ (NSMutableString *)mutableStringWithJSONData:(NSData *)JSONData;
+ (NSMutableString *)mutableStringWithJSONFile:(NSString *)pathToJSONFile;

@end
