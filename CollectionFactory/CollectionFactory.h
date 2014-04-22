@interface CollectionFactory : NSObject

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson;
+ (NSArray *)arrayWithJsonData:(NSData *)rawJson;
+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)rawJson;
+ (id)parseWithJsonData:(NSData *)rawJson options:(NSJSONReadingOptions)options mustBeOfSubclass:(Class)class;

@end
