#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD arrayWithJsonData
#define TESTING_CLASS NSArray

@interface TestCollectionFactoryForArrayWithJsonData : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForArrayWithJsonData

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil
{
    assertThat([TESTING_CLASS TESTING_METHOD:nil], willThrow(NSInvalidArgumentException));
}

- (void)testWillReturnNilWhenJsonStringIsInvalid
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:INVALID_JSON_DATA];
    assertThat(obj, nilValue());
}

- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType
{
    NSData *data = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:data];
    assertThat(obj, nilValue());
}

- (void)testWillReturnCorrectObjectWhenJsonIsValid
{
    NSData *data = [@"[123,\"abc\"]" dataUsingEncoding:NSUTF8StringEncoding];
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:data];
    assertThat(obj, contains([NSNumber numberWithInt:123], @"abc", nil));
}

@end
