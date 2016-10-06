#import "CollectionFactoryTestCase.h"
#import "SomeObject.h"
#import "NotKeyValueCompliant.h"

#define EXPECTED_JSON @"{\"string\":\"abc\",\"number\":123,\"obj\":{\"arr\":[1,\"foo\"]}}"

@interface ObjectTests : XCTestCase

@end

@implementation ObjectTests

- (void)testObjectToJSONString
{
    SomeObject1 *obj = [SomeObject1 new];
    assertThat([obj JSONString], equalTo(EXPECTED_JSON));
}

- (void)testObjectToJSONData
{
    SomeObject1 *obj = [SomeObject1 new];
    NSString *json = [[NSString alloc] initWithData:[obj JSONData]
                                           encoding:NSUTF8StringEncoding];
    assertThat(json, equalTo(EXPECTED_JSON));
}

- (void)testJSONStringToSomeObject
{
    SomeObject1 *obj = [SomeObject1 objectWithJSONString:EXPECTED_JSON];
    assertThat(obj.string, equalTo(@"abc"));
    assertThatInt(obj.number, equalToInt(123));
    assertThat(obj.obj.arr, equalTo(@[@1, @"foo"]));
}

- (void)testObjectToJSONDictionaryShouldBeSensitiveToNil
{
    SomeObject1 *obj = [SomeObject1 new];
    obj.string = nil;
    assertThat([obj JSONDictionary], hasEntry(@"string", [NSNull null]));
}

- (void)testJSONToObjectContainingNilProperties
{
    SomeObject1 *obj = [SomeObject1 objectWithJSONString:@"{\"string\":null}"];
    assertThat(obj.string, nilValue());
}

- (void)testExtraPropertyIsIgnored
{
    [SomeObject1 objectWithJSONString:@"{\"abc\":123}"];
}

- (void)testObjectIsNotKeyValueCompliant
{
    NotKeyValueCompliant *badObject = [NotKeyValueCompliant new];
    assertThat([badObject JSONDictionary], willThrowException());
}

- (void)testURLToJSONString
{
    NSURL *url = [NSURL URLWithString:@"http://google.com/foo?bar"];
    assertThat([url JSONString],
               equalTo(@"\"http:\\/\\/google.com\\/foo?bar\""));
}

- (void)testURLToJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://google.com/foo?bar"];
    NSData *expected = [@"\"http:\\/\\/google.com\\/foo?bar\""
                        dataUsingEncoding:NSUTF8StringEncoding];
    assertThat([url JSONData], equalTo(expected));
}

@end
