#import "CollectionFactoryTestCase.h"

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

@interface TestCollectionFactoryForDictionary : CollectionFactoryTestCase

@end

@implementation TestCollectionFactoryForDictionary

- (void)testCanRenderADictionaryFromAnObject
{
    SomeObject *obj = [SomeObject new];
    NSString *expected = @"{\n    number = 123;\n    string = abc;\n}";
    assertThat([NSDictionary dictionaryWithObject:obj], hasDescription(expected));
}

- (void)testCanCreateDictionaryFromJsonData
{
    NSData *data = [@"{\"a\":\"abc\"}" dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSDictionary dictionaryWithJsonData:data];
    assertThat(dictionary, hasEntry(@"a", @"abc"));
}

- (void)testCanGenerateJsonString
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"def", @"abc", nil];
    assertThat([dictionary jsonString], equalTo(@"{\"abc\":\"def\"}"));
}

@end
