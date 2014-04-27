#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD arrayWithJsonString
#define TESTING_CLASS NSArray

@interface TestCollectionFactoryForArrayWithJsonString : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForArrayWithJsonString

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil
{
    assertThat([TESTING_CLASS TESTING_METHOD:nil], willThrow(NSInvalidArgumentException));
}

- (void)testWillReturnNilWhenJsonStringIsInvalid
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:INVALID_JSON_STRING];
    assertThat(obj, nilValue());
}

- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:@"{}"];
    assertThat(obj, nilValue());
}

- (void)testWillReturnCorrectObjectWhenJsonIsValid
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:@"[123,\"abc\"]"];
    assertThat(obj, contains([NSNumber numberWithInt:123], @"abc", nil));
}

@end
