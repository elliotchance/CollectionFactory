#import <Foundation/Foundation.h>

@interface NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)JSONData;
+ (NSDictionary *)dictionaryWithJSONString:(NSString *)JSONString;
+ (NSDictionary *)dictionaryWithJSONFile:(NSString *)pathToJSONFile;

@end
