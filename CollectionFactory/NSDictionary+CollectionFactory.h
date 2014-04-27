#import <Foundation/Foundation.h>

@interface NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)rawJson;
- (NSString *)jsonString;

@end
