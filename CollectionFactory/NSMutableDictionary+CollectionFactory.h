@interface NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJsonString:(NSString *)rawJson;
+ (NSMutableDictionary *)mutableDictionaryWithJsonData:(NSData *)rawJson;
+ (NSMutableDictionary *)mutableDictionaryWithJsonFile:(NSString *)jsonFile;

@end
