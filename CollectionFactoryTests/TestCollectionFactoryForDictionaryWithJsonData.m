#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD dictionaryWithJsonData
#define TESTING_CLASS NSDictionary

@interface TestCollectionFactoryForDictionaryWithJsonData : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForDictionaryWithJsonData

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
    NSData *data = [@"[]" dataUsingEncoding:NSUTF8StringEncoding];
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:data];
    assertThat(obj, nilValue());
}

//- (void)testWillReturnCorrectObjectWhenJsonIsValid;

@end
