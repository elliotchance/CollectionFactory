#import "CollectionFactory.h"

@implementation NSURL (CollectionFactory)

- (NSString *)JSONStringOrError:(NSError **)error
{
    return [[self absoluteString] JSONStringOrError:error];
}

@end
