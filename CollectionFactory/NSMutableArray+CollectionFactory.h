@interface NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJsonString:(NSString *)jsonString;
+ (NSMutableArray *)mutableArrayWithJsonData:(NSData *)jsonData;

@end
