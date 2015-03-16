#import "CollectionFactoryTestCase.h"

@interface TestCollectionFactoryForNumber : XCTestCase

@end

@implementation TestCollectionFactoryForNumber

- (void)testTrueWillBeCovertedToJSON
{
    NSNumber *number = [NSNumber numberWithBool:YES];
    assertThat([number jsonString], equalTo(@"true"));
}

@end
