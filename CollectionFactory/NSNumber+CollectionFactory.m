#import "CollectionFactory.h"

@implementation NSNumber (CollectionFactory)

+ (NSNumber *)numberWithJSONString:(NSString *)JSONString
{
    return [CollectionFactory parseWithJSONString:JSONString
                                 mustBeOfSubclass:[NSNumber class]
                                      makeMutable:NO];
}

+ (NSNumber *)numberWithJSONData:(NSData *)JSONData
{
    return [CollectionFactory parseWithJSONData:JSONData
                               mustBeOfSubclass:[NSNumber class]
                                    makeMutable:NO];
}

- (NSString *)JSONStringOrError:(NSError **)error
{
    if(strcmp([self objCType], @encode(BOOL)) == 0) {
        if([self boolValue] == YES) {
            return @"true";
        }
        return @"false";
    }
    return [self description];
}

+ (NSNumber *)numberWithJSONFile:(NSString *)pathToJSONFile
{
    return [CollectionFactory parseWithJSONFile:pathToJSONFile
                               mustBeOfSubclass:[NSNumber class]
                                    makeMutable:NO];
}

@end
