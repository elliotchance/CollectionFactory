#import <Foundation/Foundation.h>

@interface NSArray (CollectionFactory)

+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
+ (NSArray *)arrayWithJsonData:(NSData *)jsonData;
+ (NSArray *)arrayWithJsonFile:(NSString *)jsonFile;

@end
