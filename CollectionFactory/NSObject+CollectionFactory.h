#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)JSONDictionary;
- (NSString *)JSONString;
- (NSData *)JSONData;
+ (id)objectWithJSONString:(NSString *)JSONString;
+ (id)objectWithJSONData:(NSData *)JSONData;
+ (id)objectWithJSONFile:(NSString *)pathToJSONFile;
- (void)setValue:(id)value forProperty:(NSString *)key;

@end
