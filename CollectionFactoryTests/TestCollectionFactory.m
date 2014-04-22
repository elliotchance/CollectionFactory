#import "Test.h"
#import "CollectionFactory.h"

@interface TestCollectionFactory : XCTestCase

@end

@implementation TestCollectionFactory

- (void)testCanRenderAJSONStringFromAnArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @123, nil];
    assertThat([CollectionFactory jsonStringWithArray:array], equalTo(@"[\"abc\",123]"));
}

@end
