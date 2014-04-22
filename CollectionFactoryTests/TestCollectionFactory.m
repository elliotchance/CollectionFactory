#import "Test.h"
#import "CollectionFactory.h"

@interface TestCollectionFactory : XCTestCase

@end

@implementation TestCollectionFactory

- (void)testArrayWithJSONString
{
    NSArray *array = [CollectionFactory arrayWithJsonString:@"[123,\"abc\"]"];
    assertThat(array, contains([NSNumber numberWithInt:123], @"abc", nil));
}

- (void)testWillReturnNilWhenTryingToCreateAnArrayFromANonArrayString
{
    NSArray *array = [CollectionFactory arrayWithJsonString:@"{}"];
    assertThat(array, nilValue());
}

- (void)testWillReturnNilWhenTryingToCreateAnArrayWithInvalidJson
{
    NSArray *array = [CollectionFactory arrayWithJsonString:@"[123"];
    assertThat(array, nilValue());
}

- (void)testCanRenderAJSONStringFromAnArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @123, nil];
    assertThat([CollectionFactory jsonStringWithArray:array], equalTo(@"[\"abc\",123]"));
}

@end
