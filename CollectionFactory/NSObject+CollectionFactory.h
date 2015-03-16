#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)dictionaryValue;
- (NSString *)jsonString;
- (NSData *)jsonData;
- (id)objectFromJson:(NSString *)json;

@end
