#import "CollectionFactory.h"

@implementation NSURL (CollectionFactory)

- (NSString *)JSONString
{
    return [[self absoluteString] JSONString];
}

@end
