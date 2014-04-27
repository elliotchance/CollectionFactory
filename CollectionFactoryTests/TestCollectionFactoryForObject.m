#import "CollectionFactoryTestCase.h"
#import "SomeObject.h"

@interface TestCollectionFactoryForObject : XCTestCase

@end

@implementation TestCollectionFactoryForObject

- (void)testCanRenderADictionaryFromAnObject
{
    SomeObject *obj = [SomeObject new];
    NSString *expected = @"{\n    number = 123;\n    string = abc;\n}";
    assertThat([obj dictionaryValue], hasDescription(expected));
}

@end
