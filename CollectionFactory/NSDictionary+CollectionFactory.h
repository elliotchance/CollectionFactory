#import <Foundation/Foundation.h>

@interface NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)rawJson;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)rawJson;
- (NSString *)jsonString;

@end
