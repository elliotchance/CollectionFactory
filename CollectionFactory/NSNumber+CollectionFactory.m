#import "CollectionFactory.h"

@implementation NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJSONString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJSONString:jsonString
                                 mustBeOfSubclass:[NSNumber class]
                                      makeMutable:NO];
}

+ (NSNumber *)numberWithJSONData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJSONData:jsonData
                               mustBeOfSubclass:[NSNumber class]
                                    makeMutable:NO];
}

- (NSString *)jsonString
{
    if(strcmp([self objCType], @encode(BOOL)) == 0) {
        if([self boolValue] == YES) {
            return @"true";
        }
        return @"false";
    }
    return [self description];
}

+ (NSNumber *)numberWithJSONFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJSONFile:jsonFile
                               mustBeOfSubclass:[NSNumber class]
                                    makeMutable:NO];
}

@end
