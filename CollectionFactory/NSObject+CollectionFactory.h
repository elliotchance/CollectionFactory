#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)dictionaryValue;
- (NSString *)jsonValue;
- (id)objectFromJson:(NSString *)json;

@end
