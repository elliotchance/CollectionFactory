#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)jsonDictionary;
- (NSString *)jsonString;
- (NSData *)jsonData;
+ (id)objectWithJSONString:(NSString *)jsonString;
+ (id)objectWithJSONData:(NSData *)jsonData;
+ (id)objectWithJSONFile:(NSString *)jsonFile;
- (void)setValue:(id)value forProperty:(NSString *)key;

@end
