#import <Foundation/Foundation.h>

@interface NSObject (CollectionFactory)

- (NSDictionary *)JSONDictionary;
- (NSDictionary *)JSONDictionaryOrError:(NSError **)error;
- (NSString *)JSONString;
- (NSString *)JSONStringOrError:(NSError **)error;
- (NSData *)JSONData;
- (NSData *)JSONDataOrError:(NSError **)error;

+ (id)objectWithJSONString:(NSString *)JSONString;
+ (id)objectWithJSONData:(NSData *)JSONData;
+ (id)objectWithJSONFile:(NSString *)pathToJSONFile;

- (void)setValue:(id)value forProperty:(NSString *)key;

- (NSString *)prettyJSONStringWithIndentSize:(NSUInteger)indentSize;
- (NSString *)prettyJSONStringWithIndentSize:(NSUInteger)indentSize
                                       error:(NSError **)error;

@end
