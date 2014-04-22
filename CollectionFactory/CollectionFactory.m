@implementation CollectionFactory

+ (NSArray *)arrayWithJsonData:(NSData *)rawJson
{
    return (NSArray *)[self parseWithJsonData:rawJson options:0 mustBeOfSubclass:[NSArray class]];
}

+ (NSArray *)arrayWithJsonString:(NSString *)rawJson
{
    NSData* data = [rawJson dataUsingEncoding:NSUTF8StringEncoding];
    return [CollectionFactory arrayWithJsonData:data];
}

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

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)rawJson
{
    return (NSDictionary *)[self parseWithJsonData:rawJson options:0 mustBeOfSubclass:[NSDictionary class]];
}

@end
