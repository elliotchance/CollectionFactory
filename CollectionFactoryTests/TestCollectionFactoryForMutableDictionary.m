#import "CollectionFactoryTestCase.h"

@interface TestCollectionFactoryForMutableDictionary : XCTestCase

@end

@implementation TestCollectionFactoryForMutableDictionary

- (void)testCanReturnAValueFromAKeyCreatedFromAJSONString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary mutableDictionaryWithJsonString:@"{\"a\":\"abc\"}"];
    assertTrue([[[dictionary valueForKey:@"a"] description] isEqualToString:@"abc"]);
}

- (void)testMutableDictionaryWithJsonFileThatDoesntExistReturnsNil
{
    NSMutableDictionary *dictionary = [NSMutableDictionary mutableDictionaryWithJsonFile:@"no_way_this_exists"];
    assertThat(dictionary, nilValue());
}

- (void)testWillReturnNilWhenTryingToCreateADictionaryFromANonDictionaryString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary mutableDictionaryWithJsonString:@"[123]"];
    assertThat(dictionary, nilValue());
}

- (void)testWillReturnNilWhenTryingToCreateADictionaryWithInvalidJson
{
    NSMutableDictionary *dictionary = [NSMutableDictionary mutableDictionaryWithJsonString:@"{"];
    assertThat(dictionary, nilValue());
}

- (void)testCanCreateMutableDictionaryFromJsonData
{
    NSData *data = [@"{\"a\":\"abc\"}" dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dictionary = [NSMutableDictionary mutableDictionaryWithJsonData:data];
    [dictionary setValue:@"b" forKey:@"b"];
    assertThat(dictionary, hasEntry(@"a", @"abc"));
}

- (void)testCanGenerateJsonString
{
    NSMutableDictionary *dictionary = [[NSDictionary dictionaryWithObjectsAndKeys:@"def", @"abc", nil] mutableCopy];
    assertThat([dictionary jsonString], equalTo(@"{\"abc\":\"def\"}"));
}

@end
