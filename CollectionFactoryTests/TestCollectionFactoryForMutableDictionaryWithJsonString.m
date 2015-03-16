#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD mutableDictionaryWithJsonString
#define TESTING_CLASS NSMutableDictionary

@interface TestCollectionFactoryForMutableDictionaryWithJsonString : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForMutableDictionaryWithJsonString

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
