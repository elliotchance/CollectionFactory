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

- (void)testWillReturnNilWhenTryingToCreateAnArrayWithInvalidJson
{
    NSArray *array = [CollectionFactory arrayWithJsonString:@"[123"];
    assertThat(array, nilValue());
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

@end
