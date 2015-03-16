#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD dictionaryWithJsonString
#define TESTING_CLASS NSDictionary

@interface TestCollectionFactoryForDictionaryWithJsonString : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForDictionaryWithJsonString

- (void)testWillReturnNilWhenJsonStringIsInvalid
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:INVALID_JSON_STRING];
    assertThat(obj, nilValue());
}

- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:@"[]"];
    assertThat(obj, nilValue());
}

- (void)testWillReturnCorrectObjectWhenJsonIsValid
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:@"{\"abc\":123}"];
    assertThat(obj, hasEntry(@"abc", @123));
}

@end
