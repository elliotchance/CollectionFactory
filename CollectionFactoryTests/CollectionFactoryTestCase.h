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

#define INVALID_JSON_STRING @"[123"
#define INVALID_JSON_DATA [INVALID_JSON_STRING dataUsingEncoding:NSUTF8StringEncoding]

@protocol CollectionFactoryTestCases <NSObject>

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil;
- (void)testWillReturnNilWhenJsonStringIsInvalid;
- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType;
- (void)testWillReturnCorrectObjectWhenJsonIsValid;

@end
