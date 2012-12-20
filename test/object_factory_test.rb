require 'test_helper'
require 'apexgen/object_factory'
require 'active_support/inflector'

class DefaultTest < Test::Unit::TestCase

  def setup
    @name = 'MyObject'
    @factory = Apexgen::ObjectFactory.new @name
    @header = <<-END.gsub(/^ {4}/, '').chomp
    <?xml version="1.0" encoding="UTF-8"?>
    <CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">
      <deploymentStatus>Deployed</deploymentStatus>
      <description>A custom object named #{@name}</description>
      <enableActivities>true</enableActivities>
      <enableFeeds>false</enableFeeds>
      <enableHistory>true</enableHistory>
      <enableReports>true</enableReports>
    END
    @footer = <<-END.gsub(/^ {4}/, '').chomp
      <label>#{@name.titleize}</label>
      <nameField>
        <label>#{@name.titleize} Name</label>
        <displayFormat>{0000}</displayFormat>
        <type>AutoNumber</type>
      </nameField>
      <pluralLabel>#{@name.pluralize.titleize}</pluralLabel>
      <searchLayouts/>
      <sharingModel>ReadWrite</sharingModel>
    </CustomObject>
    END
  end

  def teardown
    @name, @factory, @header, @footer = nil
  end

  def test_make_node_with_no_value
    node_name = 'TestNode'
    node = @factory.make_node(node_name)

    assert_equal node.class.to_s, "Ox::Element", 'Should return an Ox::Element object'
    assert_equal node_name, node.value, 'Should retain node name'
    assert_empty node.attributes, 'Should not have any attributes'
    assert_empty node.nodes, 'Should not have any nodes attached to it'
  end

  def test_make_node_with_value
    node_name = 'TestNode'
    node_value = "Test Value"
    node = @factory.make_node(node_name, node_value)

    assert_equal node.class.to_s, "Ox::Element", 'Should return an Ox::Element object'
    assert_equal node_name, node.value, 'Should retain node name'
    assert_empty node.attributes, 'Should not have any attributes'
    assert_equal node_value, node.nodes[0], 'Should have a value in first node position'
  end

  def test_make_nodes
    nodes = {
      firstNode:  'First Node Content',
      secondNode: 'Second Node Content',
      thirdNode:  'Third Node Content',
      fourthNode: nil
    }
    doc = Ox::Document.new(version: '1.0')
    doc << doc_root = Ox::Element.new('root')

    @factory.make_nodes(nodes, doc_root)
    doc_string = Ox.dump(doc).strip

    expected = <<-END.gsub(/^ {4}/, '').chomp
    <root>
      <firstNode>First Node Content</firstNode>
      <secondNode>Second Node Content</secondNode>
      <thirdNode>Third Node Content</thirdNode>
      <fourthNode/>
    </root>
    END
    assert doc_string.instance_of?(String), "Should dump to string"
    assert_equal expected, doc_string, "Should return correctly formatted xml as string"
  end

  def test_make_nodes_with_nested
    nodes = {
      firstNode:  'First Node Content',
      secondNode: {
        nestedOne: "First Nested Node Content",
        nestedTwo: "Second Nested Node Content",
        nestedThree: nil
      },
      thirdNode:  'Third Node Content',
      fourthNode: nil
    }
    doc = Ox::Document.new(version: 1.0)
    doc << doc_root = Ox::Element.new('root')

    @factory.make_nodes(nodes, doc_root)
    doc_string = Ox.dump(doc).strip

    expected = <<-END.gsub(/^ {4}/, '').chomp
    <root>
      <firstNode>First Node Content</firstNode>
      <secondNode>
        <nestedOne>First Nested Node Content</nestedOne>
        <nestedTwo>Second Nested Node Content</nestedTwo>
        <nestedThree/>
      </secondNode>
      <thirdNode>Third Node Content</thirdNode>
      <fourthNode/>
    </root>
    END
    assert doc_string.instance_of?(String), "Should dump to string"
    assert_equal expected, doc_string, "Should return correctly formatted xml as string"
  end

  def test_can_create_header
    xml = @factory.generate
    assert xml.include?(@header), 'Should generate correct object header'
  end

  def test_can_create_footer
    xml = @factory.generate
    assert xml.include?(@footer), 'Should generate correct object footer'
  end
end
