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

- (void)testJsonValueFromStringWillEscapeDoubleQuotes
{
    NSString *string = @"my \"string";
    assertThat([string jsonString], equalTo(@"\"my \\\"string\""));
}

- (void)testCanRenderJsonValueFromNumber
{
    NSNumber *number = @123;
    assertThat([number jsonString], equalTo(@"123"));
}

- (void)testWillCreateNumberFromRawNumber
{
    assertThat([NSObject objectFromJson:@"123"], equalTo(@123));
}

- (void)testWillCreateStringFromStringInJson
{
    assertThat([NSObject objectFromJson:@"\"123\""], equalTo(@"123"));
}

- (void)testQuotedStringsAreHandledCorrectlyWhenParsing
{
    assertThat([NSObject objectFromJson:@"\"ab\\\"c\""], equalTo(@"ab\"c"));
}

- (void)testWillCreateArrayFromJsonArray
{
    assertThat([NSObject objectFromJson:@"[\"abc\",123]"], allOf(
        instanceOf([NSArray class]),
        hasItem(@123),
    nil));
}

- (void)testWillCreateDictionaryFromJsonObject
{
    assertThat([NSObject objectFromJson:@"{\"abc\":123}"], allOf(
        instanceOf([NSDictionary class]),
        hasEntry(@"abc", @123),
    nil));
}

- (void)testWillReturnNilIfInvalidJsonIsPassedIntoObjectFromJson
{
    assertThat([NSObject objectFromJson:@"{"], nilValue());
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
    NSNumber *number = [NSObject objectFromJson:@"true"];
    assertThat(number, allOf(instanceOf([NSNumber class]), equalTo(@YES), nil));
    assertTrue(strcmp([number objCType], @encode(BOOL)) == 0);
}

- (void)testWillCreateNumberFromFalseInJson
{
    NSNumber *number = [NSObject objectFromJson:@"false"];
    assertThat(number, allOf(instanceOf([NSNumber class]), equalTo(@NO), nil));
    assertTrue(strcmp([number objCType], @encode(BOOL)) == 0);
}

- (void)testWillCreateNumberFromRawFloatingNumber
{
    assertThat([NSObject objectFromJson:@"12.3"], equalTo(@12.3));
}

@end
