#import "Test.h"

@interface TestCollectionFactoryForArray : XCTestCase

@end

@implementation TestCollectionFactoryForArray

- (void)testArrayWithJSONString
{
    NSArray *array = [NSArray arrayWithJsonString:@"[123,\"abc\"]"];
    assertThat(array, contains([NSNumber numberWithInt:123], @"abc", nil));
}

- (void)testWillReturnNilWhenTryingToCreateAnArrayFromANonArrayString
{
    NSArray *array = [NSArray arrayWithJsonString:@"{}"];
    assertThat(array, nilValue());
}

- (void)testWillReturnNilWhenTryingToCreateAnArrayWithInvalidJson
{
    NSArray *array = [NSArray arrayWithJsonString:@"[123"];
    assertThat(array, nilValue());
}

- (void)testCanRenderAJSONStringFromAnArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @123, nil];
    assertThat([array jsonString], equalTo(@"[\"abc\",123]"));
}

- (void)testArrayWithJSONData
{
    NSData *data = [NSData da]
    NSArray *array = [NSArray arrayWithJsonString:@"[123,\"abc\"]"];
    assertThat(array, contains([NSNumber numberWithInt:123], @"abc", nil));
}

@end
