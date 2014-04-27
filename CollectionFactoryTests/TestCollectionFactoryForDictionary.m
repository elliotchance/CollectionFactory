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

@interface TestCollectionFactoryForDictionary : XCTestCase

@end

@implementation TestCollectionFactoryForDictionary

- (void)testCanRenderADictionaryFromAnObject
{
    SomeObject *obj = [SomeObject new];
    NSString *expected = @"{\n    number = 123;\n    string = abc;\n}";
    assertThat([NSDictionary dictionaryWithObject:obj], hasDescription(expected));
}

- (void)testCanGenerateJsonString
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"def", @"abc", nil];
    assertThat([dictionary jsonString], equalTo(@"{\"abc\":\"def\"}"));
}

@end
