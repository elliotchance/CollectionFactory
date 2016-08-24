#import <Foundation/Foundation.h>

@interface NSMutableArray (CollectionFactory)

+ (NSMutableArray *)mutableArrayWithJSONString:(NSString *)JSONString;
+ (NSMutableArray *)mutableArrayWithJSONData:(NSData *)JSONData;
+ (NSMutableArray *)mutableArrayWithJSONFile:(NSString *)pathToJSONFile;

@end
