import time
import yaml
import json
from os import listdir


def output_test(out, test_name, lines):
    out.write('- (void)test%s\n' % test_name)
    out.write('{\n')
    out.write('\n'.join(lines))
    out.write('\n')
    out.write('}\n\n')


def parse_class(out, className, classTests):
    total = 0
    init_name = className[2:].lower()
    if 'Mutable' in str(className):
        init_name = 'mutable%s%s' % (className[9].upper(), className[10:])
    
    # Invalid JSON string to object
    output_test(out, 'InvalidJSONStringTo%s' % className[2:], (
        '    %s *object = [%s %sWithJSONString:@"[123"];' % (className, className, init_name),
        '    assertThat(object, nilValue());'
    ))
    
    # Invalid JSON data to object
    out.write('- (void)testInvalidJSONDataTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    NSData *data = [@"[123" dataUsingEncoding:NSUTF8StringEncoding];\n')
    out.write('    %s *object = [%s %sWithJSONData:data];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
        
    # Nil JSON string to object
    out.write('- (void)testNilJSONStringTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    %s *object = [%s %sWithJSONString:nil];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
        
    # Nil JSON data to object
    out.write('- (void)testNilJSONDataTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    %s *object = [%s %sWithJSONData:nil];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
    
    # File does not exist
    output_test(out, 'MissingJSONFileTo%s' % className[2:], (
        '    %s *object = [%s %sWithJSONFile:@"does_not_exist"];' % (className, className, init_name),
        '    assertThat(object, nilValue());'
    ))
    
    # Blank JSON string to object
    output_test(out, 'BlankJSONStringTo%s' % className[2:], (
        '    %s *object = [%s %sWithJSONString:@""];' % (className, className, init_name),
        '    assertThat(object, nilValue());'
    ))
    
    # Blank JSON data to object
    out.write('- (void)testBlankJSONDataTo%s\n' % className[2:])
    out.write('{\n')
    out.write('    NSData *data = [@"" dataUsingEncoding:NSUTF8StringEncoding];\n')
    out.write('    %s *object = [%s %sWithJSONData:data];\n' % (className, className, init_name))
    out.write('    assertThat(object, nilValue());\n')
    out.write('}\n\n')
    
    total += 7
    
    for testName, testConditions in classTests.items():
        object = testConditions['object']
        if 'Mutable' in className:
            if object == 'nil':
                continue
            object = '[%s mutableCopy]' % object
            testName = 'Mutable%s' % testName

        # Surround the JSON with spaces to make sure they are trimmed off
        # correctly.
        padded_json = ' \\t\\n\\r%s \\t\\n\\r' % testConditions['json']
        
        # JSON string to object
        out.write('- (void)testJSONStringTo%s\n' % testName)
        out.write('{\n')
        out.write('    %s *object = [%s %sWithJSONString:@"%s"];\n' % (className, className, init_name, padded_json))
        out.write('    assertThat(object, equalTo(%s));\n' % object)
        out.write('}\n\n')
        
        # JSON data to object
        out.write('- (void)testJSONDataTo%s\n' % testName)
        out.write('{\n')
        out.write('    NSData *data = [@"%s" dataUsingEncoding:NSUTF8StringEncoding];\n' % padded_json)
        out.write('    %s *object = [%s %sWithJSONData:data];\n' % (className, className, init_name))
        out.write('    assertThat(object, equalTo(%s));\n' % object)
        out.write('}\n\n')
    
        # From file
        output_test(out, '%sJSONFileTo%s' % (className[2:], testName), (
            '    [@"%s" writeToFile:@"test.json" atomically:NO encoding:NSUTF8StringEncoding error:nil];' % padded_json,
            '    %s *object = [%s %sWithJSONFile:@"test.json"];' % (className, className, init_name),
            '    assertThat(object, equalTo(%s));\n' % object
        ))
        
        total += 3
        
        # If there was no 'object' key the following test do not apply.
        if object == 'nil':
            continue
        
        # object to JSON string
        out.write('- (void)test%sToJSONString\n' % testName)
        out.write('{\n')
        out.write('    %s *object = %s;\n' % (className, object))
        out.write('    assertThat([object JSONString], equalTo(@"%s"));\n' % testConditions['json'])
        out.write('}\n\n')
        
        # object to JSON data
        out.write('- (void)test%sToJSONData\n' % testName)
        out.write('{\n')
        out.write('    %s *object = %s;\n' % (className, object))
        out.write('    NSString *string = [[NSString alloc] initWithData:[object JSONData]\n                                             encoding:NSUTF8StringEncoding];\n')
        out.write('    assertThat(string, equalTo(@"%s"));\n' % testConditions['json'])
        out.write('}\n\n')
        
        # object to pretty JSON string
        pretty_result = testConditions['json']
        if 'pretty' in testConditions:
            pretty_result = testConditions['pretty']
        
        out.write('- (void)test%sToPrettyJSONString\n' % testName)
        out.write('{\n')
        out.write('    %s *object = %s;\n' % (className, object))
        out.write('    NSString *result = [object prettyJSONStringWithIndentSize:2];\n')
        out.write('    assertThat(result, equalTo(@"%s"));\n' % pretty_result.replace('\n', '\\n'))
        out.write('}\n\n')
        
        total += 3

    return total


total = 0
start = time.time()

tests_file = yaml.load(open('tests.yml', 'r'))
out = open('CollectionFactoryTests.m', 'w')

out.write('// --- DO NOT EDIT THIS FILE--- \n')
out.write('// It is auto-generated from tests.yml\n\n')

out.write('#import "CollectionFactoryTestCase.h"\n')
out.write('#import "SomeObject.h"\n\n')

out.write('@interface CollectionFactoryTests : XCTestCase\n')
out.write('@end\n\n')

out.write('@implementation CollectionFactoryTests\n\n')

for className, classTests in tests_file['tests'].items():
    total += parse_class(out, className, classTests)
    
    if className != 'NSNumber' and className != 'NSObject':
        total += parse_class(out, 'NSMutable%s' % className[2:], classTests)

out.write('@end\n\n')

print('%d tests generated in %f seconds.' % (total, time.time() - start))
