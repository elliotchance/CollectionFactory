#import "CollectionFactoryTestCase.h"
#import "SomeObject.h"

#define TESTING_METHOD dictionaryWithObject
#define TESTING_CLASS NSDictionary

@interface TestCollectionFactoryForDictionaryWithObject : XCTestCase

@end

@implementation TestCollectionFactoryForDictionaryWithObject

- (void)testCanRenderADictionaryFromAnObject
{
    SomeObject *obj = [SomeObject new];
    NSString *expected = @"{\n    number = 123;\n    string = abc;\n}";
    assertThat([TESTING_CLASS TESTING_METHOD:obj], hasDescription(expected));
}

@end
