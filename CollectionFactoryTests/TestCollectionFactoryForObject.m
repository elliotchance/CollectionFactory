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
    assertThat([obj jsonString], equalTo(@"{\"string\":\"abc\",\"number\":123}"));
}

- (void)testCanRenderJsonValueFromDictionary
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"def", @"abc", nil];
    assertThat([dictionary jsonString], equalTo(@"{\"abc\":\"def\"}"));
}

- (void)testCanRenderJsonValueFromArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @123, nil];
    assertThat([array jsonString], equalTo(@"[\"abc\",123]"));
}

- (void)testCanRenderJsonValueFromString
{
    NSString *string = @"my string";
    assertThat([string jsonString], equalTo(@"\"my string\""));
}

- (void)testWillCreateStringFromStringInJson
{
    assertThat([NSObject objectWithJsonString:@"\"123\""], equalTo(@"123"));
}

- (void)testQuotedStringsAreHandledCorrectlyWhenParsing
{
    assertThat([NSObject objectWithJsonString:@"\"ab\\\"c\""], equalTo(@"ab\"c"));
}

- (void)testWillCreateArrayFromJsonArray
{
    assertThat([NSObject objectWithJsonString:@"[\"abc\",123]"], allOf(
        instanceOf([NSArray class]),
        hasItem(@123),
    nil));
}

- (void)testWillCreateDictionaryFromJsonObject
{
    assertThat([NSObject objectWithJsonString:@"{\"abc\":123}"], allOf(
        instanceOf([NSDictionary class]),
        hasEntry(@"abc", @123),
    nil));
}

- (void)testWillReturnNilIfInvalidJsonIsPassedIntoObjectFromJson
{
    assertThat([NSObject objectWithJsonString:@"{"], nilValue());
}

- (void)testCanRenderJsonValueFromBooleanNumberYes
{
    NSNumber *number = [NSNumber numberWithBool:YES];
    assertThat([number jsonString], equalTo(@"true"));
}

- (void)testCanRenderJsonValueFromBooleanNumberNo
{
    NSNumber *number = [NSNumber numberWithBool:NO];
    assertThat([number jsonString], equalTo(@"false"));
}

- (void)testWillCreateNumberFromTrueInJson
{
    NSNumber *number = [NSObject objectWithJsonString:@"true"];
    assertThat(number, allOf(instanceOf([NSNumber class]), equalTo(@YES), nil));
    assertTrue(strcmp([number objCType], @encode(BOOL)) == 0);
}

- (void)testWillCreateNumberFromFalseInJson
{
    NSNumber *number = [NSObject objectWithJsonString:@"false"];
    assertThat(number, allOf(instanceOf([NSNumber class]), equalTo(@NO), nil));
    assertTrue(strcmp([number objCType], @encode(BOOL)) == 0);
}

- (void)testWillCreateNumberFromRawFloatingNumber
{
    assertThat([NSObject objectWithJsonString:@"12.3"], equalTo(@12.3));
}

@end
