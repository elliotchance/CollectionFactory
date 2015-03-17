#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)dictionaryValue;
- (NSString *)jsonString;
- (NSData *)jsonData;
+ (id)objectWithJsonString:(NSString *)jsonString;
+ (id)objectWithJsonData:(NSData *)jsonData;

@end
