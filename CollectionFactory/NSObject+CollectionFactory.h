#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)jsonDictionary;
- (NSString *)jsonString;
- (NSData *)jsonData;
+ (id)objectWithJsonString:(NSString *)jsonString;
+ (id)objectWithJsonData:(NSData *)jsonData;
+ (id)objectWithJsonFile:(NSString *)jsonFile;

@end
