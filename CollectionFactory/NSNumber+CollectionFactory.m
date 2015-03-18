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

- (NSData *)jsonData
{
    if (strcmp([self objCType], @encode(BOOL)) == 0) {
        if ([self boolValue]) {
            return [@"true" dataUsingEncoding:NSUTF8StringEncoding];
        }
        return [@"false" dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    return [[self jsonString] dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSNumber *)numberWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithJsonFile:jsonFile
                               mustBeOfSubclass:[NSNumber class]
                                    makeMutable:NO];
}

@end
