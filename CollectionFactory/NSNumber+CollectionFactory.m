#import "CollectionFactory.h"

@implementation NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJsonString:(NSString *)jsonString
{
    return [CollectionFactory parseWithJsonString:jsonString
                                 mustBeOfSubclass:[NSNumber class]
                                      makeMutable:NO];
}

+ (NSNumber *)numberWithJsonData:(NSData *)jsonData
{
    return [CollectionFactory parseWithJsonData:jsonData
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

+ (NSNumber *)numberWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSNumber class]
                                    makeMutable:NO];
}

@end
