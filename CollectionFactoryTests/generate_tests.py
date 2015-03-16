import time
import yaml
import json
from os import listdir


def parse_class(out, className, classTests):
    total = 0
    init_name = className[2:].lower()
    if 'Mutable' in str(className):
        init_name = 'mutable%s%s' % (className[9].upper(), className[10:])
    
    # Invalid JSON string to object
    out.write('- (void)testInvalidJsonStringTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    %s *object = [%s %sWithJsonString:@"[123"];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
    
    # Invalid JSON data to object
    out.write('- (void)testInvalidJsonDataTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    NSData *data = [@"[123" dataUsingEncoding:NSUTF8StringEncoding];\n')
    out.write('    %s *object = [%s %sWithJsonData:data];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
        
    # Nil JSON string to object
    out.write('- (void)testNilJsonStringTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    %s *object = [%s %sWithJsonString:nil];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
        
    # Nil JSON data to object
    out.write('- (void)testNilJsonDataTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    %s *object = [%s %sWithJsonData:nil];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
        
    total += 4
    
    for testName, testConditions in classTests.items():
        testName = ('Mutable%s' % testName) if ('Mutable' in className) else testName
        object = testConditions['object']
        if 'Mutable' in className:
            object = '[%s mutableCopy]' % object
        
        # object to JSON string
        out.write('- (void)test%sToJsonString\n' % testName)
        out.write('{\n')
        out.write('    %s *object = %s;\n' % (className, object))
        out.write('    assertThat([object jsonString], equalTo(@"%s"));\n' % testConditions['json'])
        out.write('}\n\n')
        
        # object to JSON data
        out.write('- (void)test%sToJsonData\n' % testName)
        out.write('{\n')
        out.write('    %s *object = %s;\n' % (className, object))
        out.write('    NSString *string = [[NSString alloc] initWithData:[object jsonData]\n                                             encoding:NSUTF8StringEncoding];\n')
        out.write('    assertThat(string, equalTo(@"%s"));\n' % (testConditions['json']))
        out.write('}\n\n')
        
        # JSON string to object
        out.write('- (void)testJsonStringTo%s\n' % testName)
        out.write('{\n')
        out.write('    %s *object = [%s %sWithJsonString:@"%s"];\n' % (className, className, init_name, testConditions['json']))
        out.write('    assertThat(object, equalTo(%s));\n' % object)
        out.write('}\n\n')
        
        # JSON data to object
        out.write('- (void)testJsonDataTo%s\n' % testName)
        out.write('{\n')
        out.write('    NSData *data = [@"%s" dataUsingEncoding:NSUTF8StringEncoding];\n' % testConditions['json'])
        out.write('    %s *object = [%s %sWithJsonData:data];\n' % (className, className, init_name))
        out.write('    assertThat(object, equalTo(%s));\n' % object)
        out.write('}\n\n')
        
        total += 4

    return total


total = 0
start = time.time()

tests_file = yaml.load(open('tests.yml', 'r'))
out = open('CollectionFactoryTests.m', 'w')

out.write('// --- DO NOT EDIT THIS FILE--- \n')
out.write('// It is auto-generated from tests.yml\n\n')

out.write('#import "CollectionFactoryTestCase.h"\n\n')

out.write('@interface CollectionFactoryTests : XCTestCase\n')
out.write('@end\n\n')

out.write('@implementation CollectionFactoryTests\n\n')

for className, classTests in tests_file['tests'].items():
    total += parse_class(out, className, classTests)
    
    if className != 'NSNumber':
        total += parse_class(out, 'NSMutable%s' % className[2:], classTests)

out.write('@end\n\n')

print('%d tests generated in %f seconds.' % (total, time.time() - start))