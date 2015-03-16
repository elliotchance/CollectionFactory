#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD mutableDictionaryWithJsonData
#define TESTING_CLASS NSMutableDictionary

@interface TestCollectionFactoryForMutableDictionaryWithJsonData : XCTestCase <CollectionFactoryStaticTestCases>

@end

@implementation TestCollectionFactoryForMutableDictionaryWithJsonData

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

- (void)testWillReturnCorrectObjectWhenJsonIsValid
{
    NSData *data = [@"{\"abc\":123}" dataUsingEncoding:NSUTF8StringEncoding];
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:data];
    assertThat(obj, hasEntry(@"abc", [NSNumber numberWithInt:123]));
}

@end
