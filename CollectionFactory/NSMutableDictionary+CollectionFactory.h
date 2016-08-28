#import <Foundation/Foundation.h>

@interface NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJSONString:(NSString *)JSONString;
+ (NSMutableDictionary *)mutableDictionaryWithJSONData:(NSData *)JSONData;
+ (NSMutableDictionary *)mutableDictionaryWithJSONFile:(NSString *)pathToJSONFile;

@end
