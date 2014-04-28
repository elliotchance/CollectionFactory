#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "CollectionFactory.h"

// All tests should be using hamcrest with extensions :)
#ifndef HC_SHORTHAND
#define HC_SHORTHAND
#endif
#import <OCHamcrestExtensions/OCHamcrest.h>

#define INVALID_JSON_STRING @"[123"
#define INVALID_JSON_DATA [INVALID_JSON_STRING dataUsingEncoding:NSUTF8StringEncoding]

@protocol CollectionFactoryStaticTestCases <NSObject>

- (void)testWillThrowInvalidArgumentExceptionWhenInputIsNil;
- (void)testWillReturnNilWhenJsonStringIsInvalid;
- (void)testWillReturnNilWhenJsonStringIsValidButOfDifferentJsonType;
- (void)testWillReturnCorrectObjectWhenJsonIsValid;

@end

@protocol CollectionFactoryTestCases <NSObject>

- (void)testWillGenerateCorrectJsonStringFromObject;

@end
