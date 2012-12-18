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
      # TODO: create fields
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
          make_nodes(value, node) # Recursively call make_nodes on child nodes, appending the results back to node
        else
          node = make_node(name.to_s, value)
        end
        parent_node << node # Append value back to parent node
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
  end
end