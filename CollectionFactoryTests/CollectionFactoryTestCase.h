#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

// All tests should be using hamcrest with extensions :)
#ifndef HC_SHORTHAND
#define HC_SHORTHAND
#endif
#import <OCHamcrestExtensions/OCHamcrest.h>

// remove this when upgraded to OCHamcrestExtensions v1.0.1
#import <OCHamcrestExtensions/HCDidThrowException.h>
#import <OCHamcrestExtensions/HCThrowsException.h>

@protocol CollectionFactoryTestCases <NSObject>

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil;
- (void)testWillReturnNilWhenJsonStringIsInvalid;

@end
