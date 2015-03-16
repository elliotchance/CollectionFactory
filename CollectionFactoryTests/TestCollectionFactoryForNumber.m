#import "CollectionFactoryTestCase.h"

@interface TestCollectionFactoryForNumber : XCTestCase

@end

@implementation TestCollectionFactoryForNumber

- (void)testTrueWillBeConvertedToJSON
{
    NSNumber *number = [NSNumber numberWithBool:YES];
    assertThat([number jsonString], equalTo(@"true"));
}

- (void)testTrueWillBeCovertedFromJSON
{
    NSNumber *number = [NSNumber numberWithJsonString:@"true"];
    assertThat(number, equalTo(@YES));
}

@end
