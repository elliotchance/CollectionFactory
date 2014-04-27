#import "SomeObject.h"

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
