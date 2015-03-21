#import "SomeObject.h"

@implementation SomeObject1

- (id)init
{
    self = [super init];
    if(self) {
        self.string = @"abc";
        self.number = 123;
        self.obj = [SomeObject2 new];
    }
    return self;
}

@end

@implementation SomeObject2

- (id)init
{
    self = [super init];
    if(self) {
        self.arr = @[@1,@"foo"];
    }
    return self;
}

@end
