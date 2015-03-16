#import "NSNumber+CollectionFactory.h"
#import "NSObject+CollectionFactory.h"

@implementation NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJsonString:(NSString *)jsonString
{
    if ([jsonString isEqualToString:@"true"]) {
        return @YES;
    }
    if ([jsonString isEqualToString:@"false"]) {
        return @NO;
    }
    return [NSNumber numberWithDouble:[jsonString doubleValue]];
}

+ (NSNumber *)numberWithJsonData:(NSData *)jsonData
{
    NSString *string = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return [NSNumber numberWithJsonString:string];
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

@end
