@implementation NSMutableDictionary (CollectionFactory)

+ (NSMutableDictionary *)mutableDictionaryWithJsonString:(NSString *)rawJson
{
    if(nil == rawJson) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Argument was be nil"
                                     userInfo:nil];
    }
    NSUInteger length = [rawJson length];
    NSData *data = [NSData dataWithBytes:[rawJson cStringUsingEncoding:NSStringEncodingConversionAllowLossy]
                                  length:length];
    return [NSMutableDictionary mutableDictionaryWithJsonData:data];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonData:(NSData *)rawJson
{
    return (NSMutableDictionary *)[CollectionFactory parseWithJsonData:rawJson
                                                               options:NSJSONReadingMutableContainers
                                                      mustBeOfSubclass:[NSDictionary class]];
}

+ (NSMutableDictionary *)mutableDictionaryWithJsonFile:(NSString *)jsonFile
{
    NSData *rawJson = [[NSData alloc] initWithContentsOfFile:jsonFile];
    if(nil == rawJson) {
        return nil;
    }
    return [NSMutableDictionary mutableDictionaryWithJsonData:rawJson];
}

@end
