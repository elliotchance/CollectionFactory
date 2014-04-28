CollectionFactory
=================

Translation between native collections in Objective-C and serialized formats like JSON.

Static methods always return `nil` if an error occurs (such as JSON could not be passed or was an invalid expected type)

You may see the method `[- jsonString]`, this is an internal method you should not call directly. use the provided `[- jsonValue]` provided.

NSObject
--------

 * `+ objectFromJson:` - convert JSON string into an object.
 * `- dictionaryValue` - convert an objects properties into an `NSDictionary`.
 * `- jsonValue` - translate any object into JSON.
 
### [- jsonValue]

The kind of class is tested in this order:

 * `NSDictionary`: A JSON object is returned based on the key/values of the dictionary.
 * `NSArray`: A JSON array is returned with the items in the array.
 * `NSString`: A safely double-quoted string is returned.
 * `NSNumber`: Raw number is returned.
 * If none of the above match then the object is converted using `[- dictionaryValue]` and then the JSON for that dictionary is returned.
 
### [+ objectFromJson:]

This is the opposite of `[- jsonValue]`, it will perform the same checks in reverse.

NSArray
-------

 * `+ arrayWithJsonString:` - create an `NSArray` from a JSON string.
 * `+ arrayWithJsonData:` - create an `NSArray` from a JSON data.

NSDictionary
------------

 * `+ dictionaryWithJsonData:` - create an `NSDictionary` from a JSON data.
 * `+ dictionaryWithJsonString:` - create an `NSDictionary` from a JSON string.
 
### NSMutableDictionary

 * `+ mutableDictionaryWithJsonString:` - create an `NSMutableDictionary` from a JSON string.
 * `+ mutableDictionaryWithJsonData:` - create an `NSMutableDictionary` from a JSON data.
 * `+ mutableDictionaryWithJsonFile:` - create an `NSMutableDictionary` from a file that contains JSON.
