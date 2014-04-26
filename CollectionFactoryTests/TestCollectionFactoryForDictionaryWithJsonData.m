#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD dictionaryWithJsonData

@interface TestCollectionFactoryForDictionaryWithJsonData : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForDictionaryWithJsonData

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil
{
    assertThat([NSDictionary TESTING_METHOD:nil], willThrow(NSInvalidArgumentException));
}

//- (void)testWillReturnNilWhenJsonStringIsInvalid;
//- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType;
//- (void)testWillReturnCorrectObjectWhenJsonIsValid;

@end
