require 'active_support/inflector'
require 'ox'

module Apexgen
  class CustomObject
    def initialize(name, fields=[])
      # Set up vars
      @name = name
      @fields = fields
      @name_plural = name.pluralize
      @object_name = "#{@name}__c"
      formats = {
        'text'          => Apexgen::Field::Text.new,
        'encryptedtext' => Apexgen::Field::EncryptedText.new,
        'textarea'      => Apexgen::Field::TextArea.new,
        'longtextarea'  => Apexgen::Field::LongTextArea.new,
        'richtextarea'  => Apexgen::Field::RichTextArea.new,
        'url'           => Apexgen::Field::Url.new,
        'autonumber'    => Apexgen::Field::AutoNumber.new,
        'checkbox'      => Apexgen::Field::Checkbox.new,
        'currency'      => Apexgen::Field::Currency.new,
        'datetime'      => Apexgen::Field::DateTime.new,
        'date'          => Apexgen::Field::Date.new,
        'email'         => Apexgen::Field::Email.new,
        'geolocation'   => Apexgen::Field::Geolocation.new,
        'number'        => Apexgen::Field::Number.new,
        'percent'       => Apexgen::Field::Percent.new,
        'phone'         => Apexgen::Field::Phone.new,
      }
      # Set up the XML document
      @doc = Ox::Document.new(version: '1.0')
      # Set up doc root
      @doc_root = Ox::Element.new('CustomObject')
      @doc_root[:xmlns] = "http://soap.sforce.com/2006/04/metadata"
      @doc << @doc_root

      # Filename and path setup
      @file_name = "#{@object_name}.object"
      @dir_name = File.join(ENV['PWD'], 'objects')

      # Make the directory if it doesn't exist yet
      Dir.mkdir @dir_name unless File.directory? @dir_name

      # Make the file
      File.open(File.join(@dir_name, @file_name), "w") do |f|
        # xml = String.new
        # xml << header
        
        # @fields.each do |field|
        #   name, type = field.split(':')
        #   type = 'text' if type == nil
        #   formatter = formats[type.downcase]
        #   xml << formatter.format(name)
        # end
        
        # xml << footer
        header
        footer
        writer = ('<?xml version="1.0" encoding="UTF-8"?>' + "\n") << Ox.dump(@doc).strip
        f.write writer
      end
    end

    # Private Classes
    private

    def header
      deployment_status = Ox::Element.new('deploymentStatus')
      deployment_status << 'Deployed'
      @doc_root << deployment_status

      description = Ox::Element.new('description')
      description << "A custom object named #{@name}"
      @doc_root << description

      enable_activities = Ox::Element.new('enableActivities')
      enable_activities << 'true'
      @doc_root << enable_activities

      enable_feeds = Ox::Element.new('enableFeeds')
      enable_feeds << 'false'
      @doc_root << enable_feeds

      enable_history = Ox::Element.new('enableHistory')
      enable_history << 'true'
      @doc_root << enable_history

      enable_reports = Ox::Element.new('enableReports')
      enable_reports << 'true'
      @doc_root << enable_reports
    end

    def footer
      label = Ox::Element.new('label')
      label << @name.titleize.to_s
      @doc_root << label

      name_field = Ox::Element.new('nameField')
      @doc_root << name_field
        name_label = Ox::Element.new('label')
        name_label << "#{@name.titleize} Name"
        name_field << name_label

        name_display_format = Ox::Element.new('displayFormat')
        name_display_format << '{0000}'
        name_field << name_display_format

        name_type = Ox::Element.new('type')
        name_type << 'AutoNumber'
        name_field << name_type

      plural_label = Ox::Element.new('pluralLabel')
      plural_label << @name_plural.titleize.to_s
      @doc_root << plural_label

      search_layouts = Ox::Element.new('searchLayouts')
      @doc_root << search_layouts

      sharing_model = Ox::Element.new('sharingModel')
      sharing_model << 'ReadWrite'
      @doc_root << sharing_model
    end
  end
end
