#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)dictionaryValue;
- (NSString *)jsonString;
- (id)objectFromJson:(NSString *)json;

@end
