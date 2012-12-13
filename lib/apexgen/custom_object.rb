require 'active_support/inflector'

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
      }

      # Filename and path setup
      @file_name = "#{@object_name}.object"
      @dir_name = File.join(ENV['PWD'], 'objects')

      # Make the directory if it doesn't exist yet
      Dir.mkdir @dir_name unless File.directory? @dir_name

      # Make the file
      File.open(File.join(@dir_name, @file_name), "w") do |f|
        xml = String.new
        xml << header
        
        @fields.each do |field|
          name, type = field.split(':')
          type = 'text' if type == nil
          formatter = formats[type.downcase]
          xml << formatter.format(name)
        end
        
        xml << footer
        f.write xml
      end
    end

    # Private Classes
    private

    def header
      """
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<CustomObject xmlns=\"http://soap.sforce.com/2006/04/metadata\">
  <deploymentStatus>Deployed</deploymentStatus>
  <description>A custom object named #{@name}</description>
  <enableActivities>true</enableActivities>
  <enableFeeds>false</enableFeeds>
  <enableHistory>true</enableHistory>
  <enableReports>true</enableReports>
      """
    end

    def footer
      """
  <label>#{@name.titleize}</label>
  <nameField>
      <label>#{@name.titleize} Name</label>
      <displayFormat>{0000}</displayFormat>
      <type>AutoNumber</type>
  </nameField>
  <pluralLabel>#{@name_plural.titleize}</pluralLabel>
  <searchLayouts/>
  <sharingModel>ReadWrite</sharingModel>
</CustomObject>
      """
    end
  end
end