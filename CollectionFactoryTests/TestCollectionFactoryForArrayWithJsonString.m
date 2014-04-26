#import "CollectionFactoryTestCase.h"

@interface TestCollectionFactoryForArrayWithJsonString : XCTestCase <CollectionFactoryTestCases>

@end

@implementation TestCollectionFactoryForArrayWithJsonString

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil
{
    assertThat([NSArray arrayWithJsonString:nil], willThrow(NSInvalidArgumentException));
}

- (void)testWillReturnNilWhenJsonStringIsInvalid
{
    NSArray *array = [NSArray arrayWithJsonString:INVALID_JSON_STRING];
    assertThat(array, nilValue());
}

- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType
{
    NSArray *array = [NSArray arrayWithJsonString:@"{}"];
    assertThat(array, nilValue());
}

// ---

- (void)testArrayWithJSONString
{
    NSArray *array = [NSArray arrayWithJsonString:@"[123,\"abc\"]"];
    assertThat(array, contains([NSNumber numberWithInt:123], @"abc", nil));
}

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
