#import <Foundation/Foundation.h>

@interface NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJsonString:(NSString *)jsonString;
+ (NSMutableArray *)mutableArrayWithJsonData:(NSData *)jsonData;
+ (NSMutableArray *)mutableArrayWithJsonFile:(NSString *)jsonFile;

@end
