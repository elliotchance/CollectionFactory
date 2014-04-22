CollectionFactory
=================

Translation between native collections in Objective-C and serialized formats like JSON.

Static methods always return `nil` if an error occurs (such as JSON could not be passed or was an invalid expected type)

NSArray
-------

 * `+ arrayWithJsonString:`
 * `+ arrayWithJsonData:`
 * `- jsonString`

NSDictionary
------------

 * `+ dictionaryWithObject:`
 * `+ dictionaryWithJsonData:`
 
NSMutableDictionary
-------------------

 * `+ mutableDictionaryWithJsonString:`
 * `+ mutableDictionaryWithJsonData:`
 * `+ mutableDictionaryWithJsonFile:`