#import "NSNull+CollectionFactory.h"

@implementation NSNull (CollectionFactory)

- (NSString *)JSONStringOrError:(NSError **)error
{
    return @"null";
}

@end
