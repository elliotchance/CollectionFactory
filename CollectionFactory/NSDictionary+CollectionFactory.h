#import <Foundation/Foundation.h>

@interface NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)jsonData;
+ (NSDictionary *)dictionaryWithJSONString:(NSString *)jsonString;
+ (NSDictionary *)dictionaryWithJSONFile:(NSString *)jsonFile;

@end
