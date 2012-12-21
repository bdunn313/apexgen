require 'active_support/inflector'

module Apexgen
  class CustomObject
    def initialize(name, fields=[])
      # Set up vars
      @name = name
      @fields = fields
      @name_plural = name.pluralize
      @object_name = "#{@name}__c"

      # Filename and path setup
      @file_name = "#{@object_name}.object"
      @dir_name = File.join(ENV['PWD'], 'objects')

      # Make the directory if it doesn't exist yet
      Dir.mkdir @dir_name unless File.directory? @dir_name

      # Make the file
      File.open(File.join(@dir_name, @file_name), "w") do |f|
        creator = Apexgen::ObjectFactory.new @name
        creator.fields = @fields unless fields.empty?
        writer = creator.generate
        f.write writer
      end
    end
  end
end
