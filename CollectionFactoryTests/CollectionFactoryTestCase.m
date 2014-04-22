#import "CollectionFactoryTestCase.h"

@implementation CollectionFactoryTestCase

- (void)testCanGenerateJsonString
{
    if([self class] == [CollectionFactoryTestCase class]) {
        return;
    }
    
    @throw [NSException exceptionWithName:@"NotImplemented"
                                   reason:@"Test cases must implement [testCanGenerateJsonString]"
                                 userInfo:nil];
}

@end
