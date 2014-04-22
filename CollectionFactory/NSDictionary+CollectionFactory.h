#import <Foundation/Foundation.h>

@interface NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithObject:(id)object;
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)rawJson;
- (NSString *)jsonString;

@end
