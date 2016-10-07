#import "NotKeyValueCompliant.h"

@implementation NotKeyValueCompliant

- (id)valueForKey:(NSString *)key {
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"Something bad."
                                 userInfo:nil];
}

@end
