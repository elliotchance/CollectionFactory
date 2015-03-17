#import "CollectionFactory.h"

@implementation NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJsonString:(NSString *)jsonString
{
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([jsonString isEqualToString:@"true"]) {
        return @YES;
    }
    if ([jsonString isEqualToString:@"false"]) {
        return @NO;
    }
    
    BOOL test = [[NSScanner scannerWithString:jsonString] scanInt:nil];
    if (!test) {
        return nil;
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

+ (NSNumber *)numberWithJsonFile:(NSString *)jsonFile
{
    return [CollectionFactory parseWithFile:jsonFile
                           mustBeOfSubclass:[NSNumber class]];
}

@end
