Feature: Object
	People should be able to create apex objects
	using this application. People should also be
	able to create fields when making the object,
	and specify basic configurations for different
	field types.

	Scenario: Create Custom Object
		When I run `apexgen object`
		Then the stderr should contain "You must specify a custom object name"
		And the stdout should contain "object - Generate objects, complete with object fields and field settings."