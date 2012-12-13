require 'active_support/inflector'

module Apexgen
  module Field
    class LongTextArea
      def format(name, o={})
        # Set up default opts
        o[:externalId]   = o[:externalId]   || 'false'
        o[:length]       = o[:length]       || '32768'
        o[:required]     = o[:required]     || 'false'
        o[:trackHistory] = o[:trackHistory] || 'false'
        o[:visibleLines] = o[:visibleLines] || '3'
        # Titleize the name so we don't need to repeat the method several times
        name_title = name.titleize
        """
  <fields>
    <fullName>#{name_title.gsub(/\s/, '_')}__c</fullName>
    <description>#{name_title} Description</description>
    <externalId>#{o[:externalId]}</externalId>
    <label>#{name_title}</label>
    <length>#{o[:length]}</length>
    <required>#{o[:required]}</required>
    <trackHistory>#{o[:trackHistory]}</trackHistory>
    <type>LongTextArea</type>
    <visibleLines>#{o[:visibleLines]}</visibleLines>
  </fields>
        """
      end
    end
  end
end