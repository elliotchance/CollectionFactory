#import "CollectionFactoryTestCase.h"

#define TESTING_METHOD mutableDictionaryWithJsonFile
#define TESTING_CLASS NSMutableDictionary

@interface TestCollectionFactoryForMutableDictionaryWithJsonFile : XCTestCase

- (void)createJsonFileWithString:(NSString *)json;

@end

@implementation TestCollectionFactoryForMutableDictionaryWithJsonFile

- (void)createJsonFileWithString:(NSString *)json
{
    [json writeToFile:@"test.json"
           atomically:NO
             encoding:NSUTF8StringEncoding
                error:nil];
}

@end
