#import <Foundation/Foundation.h>

@interface NSArray (CollectionFactory)

+ (NSArray *)arrayWithJSONString:(NSString *)jsonString;
+ (NSArray *)arrayWithJSONData:(NSData *)jsonData;
+ (NSArray *)arrayWithJSONFile:(NSString *)jsonFile;

@end
