#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD jsonString

@interface TestCollectionFactoryForArrayToJsonString : XCTestCase <CollectionFactoryTestCases>

@end

@implementation TestCollectionFactoryForArrayToJsonString

- (void)testWillGenerateCorrectJsonStringFromObject
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @123, nil];
    assertThat([array TESTING_METHOD], equalTo(@"[\"abc\",123]"));
}

@end
