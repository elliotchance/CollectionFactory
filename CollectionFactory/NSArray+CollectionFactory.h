#import <Foundation/Foundation.h>

@interface NSArray (CollectionFactory)

+ (NSArray *)arrayWithJSONString:(NSString *)JSONString;
+ (NSArray *)arrayWithJSONData:(NSData *)JSONData;
+ (NSArray *)arrayWithJSONFile:(NSString *)pathToJSONFile;

@end
