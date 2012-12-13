require 'active_support/inflector'

module Apexgen
  module Field
    class AutoNumber
      def format(name, o={})
        # Titleize the name so we don't need to repeat the method several times
        name_title = name.titleize
        # Set up default opts
        o[:externalId]      = o[:externalId]      || 'false'
        o[:trackHistory]    = o[:trackHistory]    || 'false'
        o[:displayFormat]   = o[:displayFormat]   || '{0000}'
        o[:inlineHelpText]  = o[:inlineHelpText]  || "#{name_title} Help Text"
        """
  <fields>
    <fullName>#{name_title.gsub(/\s/, '_')}__c</fullName>
    <description>#{name_title} Description</description>
    <displayFormat>#{o[:displayFormat]}</displayFormat>
    <externalId>#{o[:externalId]}</externalId>
    <inlineHelpText>#{o[:inlineHelpText]}</inlineHelpText>
    <label>#{name_title}</label>
    <trackHistory>#{o[:trackHistory]}</trackHistory>
    <type>Url</type>
  </fields>
        """
      end
    end
  end
end