Feature: Object
	People should be able to create apex objects
	using this application. People should also be
	able to create fields when making the object,
	and specify basic configurations for different
	field types.

  Scenario: Get help for custom object.
    When I run `apexgen help object`
    Then the stdout should contain "object - Generate objects, complete with object fields and field settings."

  Scenario: Get help for custom object with help flag.
    When I run `apexgen object --help`
    Then the stdout should contain "object - Generate objects, complete with object fields and field settings."

  Scenario: Try to create a custom object without a name.
    When I run `apexgen object`
    Then the stderr should contain "You must specify a custom object name"
    And the stdout should contain "object - Generate objects, complete with object fields and field settings."

  Scenario: Create a custom object.
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<pluralLabel>Test Objects"

  Scenario: Create a custom object with one field. The field type defaults to Text.
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Text"