@interface NSArray (CollectionFactory)

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson;
+ (NSArray *)arrayWithJsonData:(NSData *)rawJson;
- (NSString *)jsonString;

@end
