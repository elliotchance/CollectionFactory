#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD mutableDictionaryWithJsonFile
#define TESTING_CLASS NSMutableDictionary

@interface TestCollectionFactoryForMutableDictionaryWithJsonFile : XCTestCase

@end

@implementation TestCollectionFactoryForMutableDictionaryWithJsonFile

- (void)testMutableDictionaryWithJsonFileThatDoesntExistReturnsNil
{
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:@"no_way_this_exists"];
    assertThat(obj, nilValue());
}

- (void)testCanCreateMutableDictionaryFromValidJsonFile
{
    [@"{\"xyz\":456}" writeToFile:@"test.json"
                       atomically:NO
                         encoding:NSUTF8StringEncoding
                            error:nil];
    TESTING_CLASS *obj = [TESTING_CLASS TESTING_METHOD:@"test.json"];
    assertThat(obj, hasEntry(@"xyz", [NSNumber numberWithInteger:456]));
}

@end
