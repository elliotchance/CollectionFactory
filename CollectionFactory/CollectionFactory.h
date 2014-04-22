@interface CollectionFactory : NSObject

+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (id)parseWithJsonData:(NSData *)rawJson options:(NSJSONReadingOptions)options mustBeOfSubclass:(Class)class;

@end
