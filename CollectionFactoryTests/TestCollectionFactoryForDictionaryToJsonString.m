#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD jsonString
#define TESTING_CLASS NSDictionary

@interface TestCollectionFactoryForDictionaryToJsonString : XCTestCase <CollectionFactoryTestCases>

@end

@implementation TestCollectionFactoryForDictionaryToJsonString

- (void)testWillGenerateCorrectJsonStringFromObject
{
    TESTING_CLASS *dictionary = [TESTING_CLASS dictionaryWithObjectsAndKeys:@"def", @"abc", nil];
    assertThat([dictionary jsonString], equalTo(@"{\"abc\":\"def\"}"));
}

@end
