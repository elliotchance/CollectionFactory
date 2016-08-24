#import <Foundation/Foundation.h>

@interface NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJSONString:(NSString *)jsonString;
+ (NSMutableDictionary *)mutableDictionaryWithJSONData:(NSData *)jsonData;
+ (NSMutableDictionary *)mutableDictionaryWithJSONFile:(NSString *)jsonFile;

@end
