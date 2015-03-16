#import "NSNumber+CollectionFactory.h"

@implementation NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJsonString:(NSString *)jsonString
{
    return @YES;
}

- (NSData *)jsonData
{
    if ([self boolValue]) {
        return [@"true" dataUsingEncoding:NSUTF8StringEncoding];
    }
    return [@"false" dataUsingEncoding:NSUTF8StringEncoding];
}

@end
