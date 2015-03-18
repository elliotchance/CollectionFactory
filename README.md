CollectionFactory
=================

Translation between native collections in Objective-C and serialized formats
like JSON.

Static methods always return `nil` if an error occurs (such as JSON could not be
passed, was nil, or was an invalid expected type).


Converting to JSON
------------------

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


Converting from JSON
--------------------

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

### Creating Mutable Objects

For every factory method there is a mutable counterpart used for generating
objects that be safely editly directly after unpacking.

```objc
NSString *json = @"{\"foo\":\"bar\"}";
NSDictionary *d = [NSDictionary dictionaryWithJsonString:json];
NSMutableDictionary *md = [NSMutableDictionary mutableDictionaryWithJsonString:json];
```

### Creating Objects From Files

You can read JSON an as entire file and unpack it with the respective methods:

  * [NSDictionary dictionaryWithJsonFile:@"foo.json"];
