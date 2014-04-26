#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD arrayWithJsonData

@interface TestCollectionFactoryForArrayWithJsonData : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForArrayWithJsonData

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil
{
    assertThat([NSArray TESTING_METHOD:nil], willThrow(NSInvalidArgumentException));
}

- (void)testWillReturnNilWhenJsonStringIsInvalid
{
    NSArray *array = [NSArray TESTING_METHOD:INVALID_JSON_DATA];
    assertThat(array, nilValue());
}

- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType
{
    NSData *data = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSArray TESTING_METHOD:data];
    assertThat(array, nilValue());
}

- (void)testWillReturnCorrectObjectWhenJsonIsValid
{
    NSData *data = [@"[123,\"abc\"]" dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSArray TESTING_METHOD:data];
    assertThat(array, contains([NSNumber numberWithInt:123], @"abc", nil));
}

@end
