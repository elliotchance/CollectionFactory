#import "CollectionFactoryTestCase.h"

@interface TestCollectionFactoryForArray : XCTestCase

@end

@implementation TestCollectionFactoryForArray

- (void)testCanRenderAJSONStringFromAnArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @123, nil];
    assertThat([array jsonString], equalTo(@"[\"abc\",123]"));
}

- (void)testArrayWithJSONData
{
    NSData *data = [@"[123,\"abc\"]" dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSArray arrayWithJsonData:data];
    assertThat(array, contains([NSNumber numberWithInt:123], @"abc", nil));
}

- (void)testCanGenerateJsonString
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", nil];
    assertThat([array jsonString], equalTo(@"[\"abc\"]"));
}

@end
