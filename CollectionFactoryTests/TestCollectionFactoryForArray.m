#import "CollectionFactoryTestCase.h"

@interface TestCollectionFactoryForArray : XCTestCase

@end

@implementation TestCollectionFactoryForArray

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
