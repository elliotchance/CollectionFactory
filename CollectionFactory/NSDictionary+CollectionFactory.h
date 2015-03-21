@interface NSDictionary (CollectionFactory)

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSDictionary *)dictionaryWithJsonFile:(NSString *)jsonFile;

@end
