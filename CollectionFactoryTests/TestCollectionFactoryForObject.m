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

- (void)testCanRenderJsonValueFromObject
{
    SomeObject *obj = [SomeObject new];
    assertThat([obj jsonValue], equalTo(@"{\"string\":\"abc\",\"number\":123}"));
}

- (void)testCanRenderJsonValueFromDictionary
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"def", @"abc", nil];
    assertThat([dictionary jsonValue], equalTo(@"{\"abc\":\"def\"}"));
}

@end
