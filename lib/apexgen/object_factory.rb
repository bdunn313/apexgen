require 'ox'
require 'active_support/inflector'
module Apexgen
  class ObjectFactory
    # Expose fields so it does not need to be set on initialization
    attr_accessor :fields
    # Initialization
    def initialize(object_name, fields={})
      # Setters
      @name = object_name
      @fields = fields
      # Set up the XML document
      @doc = Ox::Document.new(version: '1.0')
      @doc_root = Ox::Element.new('CustomObject')
      @doc_root[:xmlns] = "http://soap.sforce.com/2006/04/metadata"
      @doc << @doc_root
      @dtd = '<?xml version="1.0" encoding="UTF-8"?>' + "\n"
    end

    # Create the XML and return XML string
    def generate
      create_header
      unless @fields.empty?
        @fields.each { |field| create_field(field) }
      end
      create_footer
      @dtd << Ox.dump(@doc).strip
    end

    # Make and return a single node
    def make_node(name, value=nil, attributes={})
      node = Ox::Element.new(name)

      node << value unless value.nil?
      attributes.each { |att, val| node[att] = val } unless attributes.empty?
      
      node
    end

    # Make multiple nodes, appending to the parent passed to the method
    def make_nodes(nodes, parent_node)
      nodes.each do |name, value|
        if value.kind_of?(Hash)
          node = Ox::Element.new(name.to_s)
          make_nodes(value, node)
        else
          node = make_node(name.to_s, value)
        end
        parent_node << node
        parent_node
      end
    end

    # Private Methods
    private

    # Create the header for an object
    def create_header
      nodes = {
        deploymentStatus: 'Deployed',
        description: "A custom object named #{@name}",
        enableActivities: 'true',
        enableFeeds: 'false',
        enableHistory: 'true',
        enableReports: 'true'
      }
      make_nodes(nodes, @doc_root)
    end

    def create_footer
      nodes = {
        label: @name.titleize.to_s,
        nameField: {
          label: "#{@name.titleize} Name",
          displayFormat: '{0000}',
          type: 'AutoNumber',
          },
        pluralLabel: @name.pluralize.titleize.to_s,
        searchLayouts: nil,
        sharingModel: 'ReadWrite',
      }
      make_nodes(nodes, @doc_root)
    end

    def create_field(field)
      field_name, field_type = field.split(":")
      nodes = get_field_nodes(field_name, field_type.downcase!)
      make_nodes(nodes, @doc_root)
    end

    def get_field_nodes(field_name, field_type, options={})
      base_nodes = {
        fullName: "#{field_name.titleize.tr(" ", "_")}__c",
        description: "#{field_name.titleize} Description",
        externalId: false,
        required: false,
        label: "#{field_name.titleize}",
        trackHistory: false,
      }
      nodes_by_type = {
        'autonumber' => { 
          displayFormat: "AUTO-{0000}",
          type: 'AutoNumber',
          },
        'checkbox' => { 
          defaultValue: nil,
          type: 'Checkbox',
          },
        'currency' => {
          precision: '14',
          scale: '2',
          type: 'Currency',
          },
        'date' => { 
          type: 'Date',
          },
        'datetime' => { 
          type: 'DateTime',
          },
        'email' => { 
          unique: 'false',
          type: 'Email',
          },
        'geolocation' => { 
          displayLocationInDecimal: 'false',
          scale: '2',
          type: 'Location',
          },
        'number' => {
          precision: '14',
          scale: '2',
          unique: 'false',
          type: 'Number',
          },
        'percent' => {
          precision: '14',
          scale: '2',
          type: 'Percent',
          },
        'phone' => { 
          type: 'Phone',
          },
        'picklist' => {
          picklist: {
            picklistValues: {
              fullName: 'Field 1',
              default: 'false',
              },
            sorted: 'false',
            },
          type: 'Picklist',
          },
        'picklistmulti' => {
          picklist: {
            picklistValues: {
              fullName: 'Field 1',
              default: 'false',
              },
            sorted: 'false',
            },
          visibleLines: '4',
          type: 'MultiselectPicklist',
          },
        'text' => {
          length: '',
          unique: 'false',
          type: 'Text',
          },
        'textarea' => { 
          type: 'TextArea',
          },
        'longtextarea' => {
          length: '',
          visibleLines: '3',
          type: 'LongTextArea',
          },
        'encryptedtext' => {
          length: '',
          maskChar: 'asterisk',
          maskType: 'all',
          type: 'EncryptedText',
          },
        'richtextarea' => {
          length: '',
          visibleLines: '3',
          type: 'Html',
          },
        'url' => { 
          type: 'Url',
          },
      }
      field_nodes = base_nodes.merge(nodes_by_type[field_type])
      return_nodes = {fields: field_nodes}
      return_nodes
    end
  end
end