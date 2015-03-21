@interface NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJsonString:(NSString *)jsonString;
+ (NSMutableDictionary *)mutableDictionaryWithJsonData:(NSData *)jsonData;
+ (NSMutableDictionary *)mutableDictionaryWithJsonFile:(NSString *)jsonFile;

@end
