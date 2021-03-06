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

  Scenario: Create a custom object with one field.
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:text`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Text"

  Scenario: Create a custom object with one field. Type case should not matter.
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:TeXt`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Text"

  Scenario: Create a custom object with a Text Area and a Text Area Long
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:TextArea AnotherField:LongTextArea`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>TextArea"
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Another_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Another Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>LongTextArea"
    And the file "objects/TestObject__c.object" in my current directory should contain "<visibleLines>3"

  Scenario: Create a custom object with a Rich Text Area and an Encrypted Text Field
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:RichTextArea AnotherField:EncryptedText`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Html"
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Another_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Another Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>EncryptedText"
    And the file "objects/TestObject__c.object" in my current directory should contain "<maskChar>asterisk"

  Scenario: Create a custom object with a Url and an Auto Number Field
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:Url AnotherField:AutoNumber`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Url"
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Another_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Another Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>AutoNumber"
    And the file "objects/TestObject__c.object" in my current directory should contain "<displayFormat>{0000}"

  Scenario: Create a custom object with a Checkbox and a Currency field
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:Checkbox AnotherField:Currency`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Checkbox"
    And the file "objects/TestObject__c.object" in my current directory should contain "<defaultValue>false"
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Another_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Another Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Currency"
    And the file "objects/TestObject__c.object" in my current directory should contain "<precision>18"

  Scenario: Create a custom object with a DateTime and a Date field
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:DateTime AnotherField:Date`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>DateTime"
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Another_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Another Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Date"

  Scenario: Create a custom object with a Geolocation and a Number field
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:Geolocation AnotherField:Number`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Location"
    And the file "objects/TestObject__c.object" in my current directory should contain "<displayLocationInDecimal>false"
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Another_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Another Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Number"
    And the file "objects/TestObject__c.object" in my current directory should contain "<precision>18"

  Scenario: Create a custom object with a Percent and a Phone field
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:Percent AnotherField:Phone`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Percent"
    And the file "objects/TestObject__c.object" in my current directory should contain "<precision>18"
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Another_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Another Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Phone"

  Scenario: Create a custom object with an field
    Given the file "objects/TestObject__c.object" doesn't exist in my current directory
    When I successfully run `apexgen object TestObject SomeField:Email`
    Then a file named "objects/TestObject__c.object" should exist in my current directory
    And the file "objects/TestObject__c.object" in my current directory should contain "<fullName>Some_Field__c"
    And the file "objects/TestObject__c.object" in my current directory should contain "<label>Some Field"
    And the file "objects/TestObject__c.object" in my current directory should contain "<type>Email"