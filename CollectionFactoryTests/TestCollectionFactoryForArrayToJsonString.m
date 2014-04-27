#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD jsonString
#define TESTING_CLASS NSArray

@interface TestCollectionFactoryForArrayToJsonString : XCTestCase <CollectionFactoryTestCases>

@end

@implementation TestCollectionFactoryForArrayToJsonString

- (void)testWillGenerateCorrectJsonStringFromObject
{
    TESTING_CLASS *array = [TESTING_CLASS arrayWithObjects:@"abc", @123, nil];
    assertThat([array TESTING_METHOD], equalTo(@"[\"abc\",123]"));
}

@end
