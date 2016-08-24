#import <Foundation/Foundation.h>

@interface NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJSONString:(NSString *)jsonString;
+ (NSMutableArray *)mutableArrayWithJSONData:(NSData *)jsonData;
+ (NSMutableArray *)mutableArrayWithJSONFile:(NSString *)jsonFile;

@end
