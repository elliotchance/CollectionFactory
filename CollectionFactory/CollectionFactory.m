#import "CollectionFactory.h"

@implementation CollectionFactory

+ (id)parseWithJsonData:(NSData *)rawJson
                options:(NSJSONReadingOptions)options
       mustBeOfSubclass:(Class)class
{
    id json = [NSJSONSerialization JSONObjectWithData:rawJson options:options error:nil];
    if(![[json class] isSubclassOfClass:class]) {
        return nil;
    }
    
    return json;
}

@end
