CollectionFactory
=================

[![Build Status](https://travis-ci.org/elliotchance/CollectionFactory.svg?branch=master)](https://travis-ci.org/elliotchance/CollectionFactory)

Translation between native collections in Objective-C and serialized formats
like JSON.

Static methods always return `nil` if an error occurs (such as JSON could not be
passed, was nil, or was an invalid expected type).


Converting to JSON
------------------

### Native Types

You can use `jsonString` or `jsonData` to get the NSString or NSData encoded
versions in JSON respectively.

```objc
NSDictionary *d = @{@"foo": @"bar"};

// {"foo":"bar"}
NSString *jsonString = [d jsonString];

// The same value as above but as a NSData
NSData *jsonData = [d jsonData];
```

Both methods are available on `NSNull`, `NSNumber`, `NSArray`, `NSDictionary`,
`NSObject`, and `NSString`.

### Custom Types

You may also convert any subclass of `NSObject`:

```objc
@interface SomeObject : NSObject

@property NSString *string;
@property int number;

@end
```

```objc
SomeObject *myObject = [SomeObject new];
myObject.string = @"foo";
myObject.number = 123;

// {"string":"foo","number":123}
NSString *json = [myObject jsonString];
```

If you need to control how custom objects are serialized you may override the
`[jsonDictionary]` method:

```objc
@implementation SomeObject

- (NSDictionary *)jsonDictionary
{
    return @{
        @"number": self.number,
        @"secret": @"bar",
    };
}

@end
```

```objc
SomeObject *myObject = [SomeObject new];
myObject.string = @"foo";
myObject.number = 123;

// {"number":123,"secret":"bar"}
NSString *json = [myObject jsonString];
```

Converting from JSON
--------------------

### Native Types

The simplest way to convert JSON to an object is to run it through NSObject:

```objc
NSString *json = @"{\"foo\":\"bar\"}";
id object = [NSObject objectWithJsonString:json];
```

However, if you know the type of the incoming value you should use the
respective class factory (rather than blindly casting):

```objc
NSString *json = @"{\"foo\":\"bar\"}";
NSDictionary *d = [NSDictionary dictionaryWithJsonString:json];
```

When using a specific class it will not accept a valid JSON value of an
unexpected type to prevent bugs occuring, for example:

```objc
NSString *json = @"{\"foo\":\"bar\"}";

// `a` is `nil` because we only intend to decode a JSON array.
NSArray *a = [NSArray arrayWithJsonString:json];

// `b` is an instance of `NSDictionary` but future code will be treating it like
// an `NSArray` which will surely cause very bad things to happen...
NSArray *b = [NSObject objectWithJsonString:json];
```

### Custom Types

Let's say you have this:

```objc
@interface SomeObject : NSObject

@property NSString *string;
@property int number;

@end
```

The same method that unwraps native types is used except because the static
method `[objectWithJsonString:]` is called against `SomeObject` you are saying
that it must unserialize to that type of object.

```objc
NSString *json = @"{\"string\":\"foo\",\"number\":123};

SomeObject *myObject = [SomeObject objectWithJsonString:json];

// 123
myObject.number;

// Do NOT do this. Otherwise you will get an NSDictionary.
// SomeObject *myObject = [NSObject objectWithJsonString:json];
```

### Creating Mutable Objects

For every factory method there is a mutable counterpart used for generating
objects that be safely editly directly after unpacking.

```objc
NSString *json = @"{\"foo\":\"bar\"}";
NSDictionary *d = [NSDictionary dictionaryWithJsonString:json];
NSMutableDictionary *md = [NSMutableDictionary mutableDictionaryWithJsonString:json];
```

### Creating Objects From Files

Each factory method also has a way to generate the object directly from a file:

```objc
NSArray *foo = [NSArray arrayWithJsonFile:@"foo.json"];
```

If the file does not exist, there was an error parsing or the JSON was the wrong
type then `nil` will be returned.

Futhermore you can create mutable objects from files:

```objc
NSMutableArray *foo = [NSMutableArray mutableArrayWithJsonFile:@"foo.json"];
```
