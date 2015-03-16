#import "CollectionFactoryTestCase.h"

@interface TestCollectionFactoryForNumber : XCTestCase

@end

@implementation TestCollectionFactoryForNumber

- (void)testTrueWillBeConvertedToJsonString
{
    NSNumber *number = [NSNumber numberWithBool:YES];
    assertThat([number jsonString], equalTo(@"true"));
}

- (void)testTrueWillBeConvertedFromJsonString
{
    NSNumber *number = [NSNumber numberWithJsonString:@"true"];
    assertThat(number, equalTo(@YES));
}

- (void)testFalseWillBeConvertedToJsonString
{
    NSNumber *number = [NSNumber numberWithBool:NO];
    assertThat([number jsonString], equalTo(@"false"));
}

@end
