#import "CollectionFactoryTestCase.h"
#import "SomeObject.h"

#define EXPECTED_JSON @"{\"string\":\"abc\",\"number\":123,\"obj\":{\"arr\":[1,\"foo\"]}}"

@interface ObjectTests : XCTestCase

@end

@implementation ObjectTests

- (void)testObjectToJsonString
{
    SomeObject1 *obj = [SomeObject1 new];
    assertThat([obj jsonString], equalTo(EXPECTED_JSON));
}

- (void)testObjectToJsonData
{
    SomeObject1 *obj = [SomeObject1 new];
    NSString *json = [[NSString alloc] initWithData:[obj jsonData]
                                           encoding:NSUTF8StringEncoding];
    assertThat(json, equalTo(EXPECTED_JSON));
}

@end
