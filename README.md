CollectionFactory
=================

[![Build Status](https://travis-ci.org/elliotchance/CollectionFactory.svg?branch=master)](https://travis-ci.org/elliotchance/CollectionFactory)

Translation between native collections in Objective-C and JSON.

Static methods always return `nil` if an error occurs (such as JSON could not be
passed, was nil, or was an invalid expected type).


* [Converting to JSON](#converting-to-json)
* [Converting from JSON](#converting-from-json)
* [Pretty Printing](#pretty-printing)
* [Creating Mutable Objects](#creating-mutable-objects)
* [Loading from Files](#loading-from-files)


Converting to JSON
------------------

### Native Types

You can use `JSONString` or `JSONData` to get the NSString or NSData encoded
versions in JSON respectively.

```objc
NSDictionary *d = @{@"foo": @"bar"};

// {"foo":"bar"}
NSString *JSONString = [d JSONString];

// The same value as above but as a NSData
NSData *JSONData = [d JSONData];
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
NSString *json = [myObject JSONString];
```

If you need to control how custom objects are serialized you may override the
`[JSONDictionary]` method:

```objc
@implementation SomeObject

- (NSDictionary *)JSONDictionary
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
NSString *json = [myObject JSONString];
```

Converting from JSON
--------------------

### Native Types

The simplest way to convert JSON to an object is to run it through NSObject:

```objc
NSString *json = @"{\"foo\":\"bar\"}";
id object = [NSObject objectWithJSONString:json];
```

However, if you know the type of the incoming value you should use the
respective class factory (rather than blindly casting):

```objc
NSString *json = @"{\"foo\":\"bar\"}";
NSDictionary *d = [NSDictionary dictionaryWithJSONString:json];
```

When using a specific class it will not accept a valid JSON value of an
unexpected type to prevent bugs occuring, for example:

```objc
NSString *json = @"{\"foo\":\"bar\"}";

// `a` is `nil` because we only intend to decode a JSON array.
NSArray *a = [NSArray arrayWithJSONString:json];

// `b` is an instance of `NSDictionary` but future code will be treating it like
// an `NSArray` which will surely cause very bad things to happen...
NSArray *b = [NSObject objectWithJSONString:json];
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
method `[objectWithJSONString:]` is called against `SomeObject` you are saying
that it must unserialize to that type of object.

```objc
NSString *json = @"{\"string\":\"foo\",\"number\":123};

SomeObject *myObject = [SomeObject objectWithJSONString:json];

// 123
myObject.number;

// Do NOT do this. Otherwise you will get an NSDictionary.
// SomeObject *myObject = [NSObject objectWithJSONString:json];
```

Objects are contructed recursively by first checking to see if the property
exists, if it does and the data is not prefixed with `NS` it will create another
custom object and continue. This means JSON can be used to unpack simple objects
without any specific code however this has some caveats:

  1. It is dangerous. Not all properties are public or even exist so types can
     be easily missing and cause serious memory error when trying to use the
     unpacked objects.

  2. It will always use the `[init]` constructor which may be wrong or not even
     available making the object constructions impossible.

A much safer way to unpack objects is to override the `[setValue:forProperty:]`
method. This allows you to control exactly what logic you need with each
property.

Note: This is is a wrapper for `[setValue:forKey:]` and will call
`[setValue:forKey:]` if you have not overridden it.

```objc
@implementation SomeObject

- (void)setValue:(id)value forProperty:(NSString *)key
{
    // Only allow these two properties to be set.
    NSArray *properties = @[@"number", @"string"];
    if ([properties indexOfObject:key] != NSNotFound) {
        [self setValue:value forKey:key];
    }
}

@end
```

Pretty Printing
---------------

By default serialized JSON will not contain extra spaces which is best for
transmission and storage but it is less readable for debugging. You can generate
pretty JSON by specifying the indent size:

```objc
NSDictionary *object = @{@"abc": @"def"};

// {
//   "abc": "def"
// }
NSString *result = [object prettyJSONStringWithIndentSize:2];
```

Creating Mutable Objects
------------------------

For every factory method there is a mutable counterpart used for generating
objects that be safely editly directly after unpacking.

```objc
NSString *json = @"{\"foo\":\"bar\"}";
NSDictionary *d = [NSDictionary dictionaryWithJSONString:json];
NSMutableDictionary *md = [NSMutableDictionary mutableDictionaryWithJSONString:json];
```

Loading from Files
------------------

Each factory method also has a way to generate the object directly from a file:

```objc
NSArray *foo = [NSArray arrayWithJSONFile:@"foo.json"];
```

If the file does not exist, there was an error parsing or the JSON was the wrong
type then `nil` will be returned.

Futhermore you can create mutable objects from files:

```objc
NSMutableArray *foo = [NSMutableArray mutableArrayWithJSONFile:@"foo.json"];
```
