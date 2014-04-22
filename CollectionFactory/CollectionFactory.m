@implementation CollectionFactory

+ (NSString *)jsonStringWithArray:(NSArray *)array
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (id)parseWithJsonData:(NSData *)rawJson options:(NSJSONReadingOptions)options mustBeOfSubclass:(Class)class
{
    id json = [NSJSONSerialization JSONObjectWithData:rawJson options:options error:nil];
    if(![[json class] isSubclassOfClass:class]) {
        return nil;
    }
    
    return json;
}

@end
