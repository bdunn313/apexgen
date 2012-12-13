require 'active_support/inflector'

module Apexgen
  module Field
    class TextArea
      def format(name, o={})
        # Set up default opts
        o[:externalId]   = o[:externalId]   || 'false'
        o[:required]     = o[:required]     || 'false'
        o[:trackHistory] = o[:trackHistory] || 'false'
        # Titleize the name so we don't need to repeat the method several times
        name_title = name.titleize
        """
  <fields>
    <fullName>#{name_title.gsub(/\s/, '_')}__c</fullName>
    <description>#{name_title} Description</description>
    <externalId>#{o[:externalId]}</externalId>
    <label>#{name_title}</label>
    <required>#{o[:required]}</required>
    <trackHistory>#{o[:trackHistory]}</trackHistory>
    <type>TextArea</type>
    
  </fields>
        """
      end
    end
  end
end