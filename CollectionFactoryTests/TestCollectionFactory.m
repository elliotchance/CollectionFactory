#import "Test.h"
#import "CollectionFactory.h"

@interface SomeObject : NSObject

@property NSString *string;
@property NSInteger number;

@end

@implementation SomeObject

- (id)init
{
    self = [super init];
    if(self) {
        self.string = @"abc";
        self.number = 123;
    }
    return self;
}

@end

@interface TestCollectionFactory : XCTestCase

@end

@implementation TestCollectionFactory

- (void)testCanReturnAValueFromAKeyCreatedFromAJSONString
{
    NSMutableDictionary *dictionary = [CollectionFactory mutableDictionaryWithJsonString:@"{\"a\":\"abc\"}"];
    assertTrue([[[dictionary valueForKey:@"a"] description] isEqualToString:@"abc"]);
}

- (void)testMutableDictionaryWithJsonFileThatDoesntExistReturnsNil
{
    NSMutableDictionary *dictionary = [CollectionFactory mutableDictionaryWithJsonFile:@"no_way_this_exists"];
    assertThat(dictionary, nilValue());
}

- (void)testArrayWithJSONString
{
    NSArray *array = [CollectionFactory arrayWithJsonString:@"[123,\"abc\"]"];
    assertThat(array, contains([NSNumber numberWithInt:123], @"abc", nil));
}

- (void)testWillReturnNilWhenTryingToCreateAnArrayFromANonArrayString
{
    NSArray *array = [CollectionFactory arrayWithJsonString:@"{}"];
    assertThat(array, nilValue());
}

- (void)testWillReturnNilWhenTryingToCreateADictionaryFromANonDictionaryString
{
    NSMutableDictionary *dictionary = [CollectionFactory mutableDictionaryWithJsonString:@"[123]"];
    assertThat(dictionary, nilValue());
}

- (void)testWillReturnNilWhenTryingToCreateAnArrayWithInvalidJson
{
    NSArray *array = [CollectionFactory arrayWithJsonString:@"[123"];
    assertThat(array, nilValue());
}

- (void)testWillReturnNilWhenTryingToCreateADictionaryWithInvalidJson
{
    NSMutableDictionary *dictionary = [CollectionFactory mutableDictionaryWithJsonString:@"{"];
    assertThat(dictionary, nilValue());
}

- (void)testCanRenderADictionaryFromAnObject
{
    SomeObject *obj = [SomeObject new];
    NSString *expected = @"{\n    number = 123;\n    string = abc;\n}";
    assertThat([CollectionFactory dictionaryWithObject:obj], hasDescription(expected));
}

- (void)testCanRenderAJSONStringFromAnArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @123, nil];
    assertThat([CollectionFactory jsonStringWithArray:array], equalTo(@"[\"abc\",123]"));
}

- (void)testCanCreateDictionaryFromJsonData
{
    NSData *data = [@"{\"a\":\"abc\"}" dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [CollectionFactory dictionaryWithJsonData:data];
    assertThat(dictionary, hasEntry(@"a", @"abc"));
}

- (void)testCanCreateMutableDictionaryFromJsonData
{
    NSData *data = [@"{\"a\":\"abc\"}" dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dictionary = [CollectionFactory mutableDictionaryWithJsonData:data];
    [dictionary setValue:@"b" forKey:@"b"];
    assertThat(dictionary, hasEntry(@"a", @"abc"));
}

@end
