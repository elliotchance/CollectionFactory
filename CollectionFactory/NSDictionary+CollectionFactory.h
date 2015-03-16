#import <Foundation/Foundation.h>

@interface NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
