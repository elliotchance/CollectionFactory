#import "CollectionFactory.h"

@implementation CollectionFactory

+ (id)parseWithJsonData:(NSData *)jsonData
                options:(NSJSONReadingOptions)options
       mustBeOfSubclass:(Class)class
{
    // NSJSONSerialization will throw an NSInvalidArgumentException if
    // `jsonData` is nil but we want to always return `nil` on error.
    if (nil == jsonData) {
        return nil;
    }
    
    id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:options
                                                error:nil];
    if(![[json class] isSubclassOfClass:class]) {
        return nil;
    }
    
    return json;
}

@end
