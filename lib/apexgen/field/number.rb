require 'active_support/inflector'

module Apexgen
  module Field
    class Number
      def format(name, o={})
        # Titleize the name so we don't need to repeat the method several times
        name_title = name.titleize
        # Set up default opts
        o[:externalId]               = o[:externalId]                || 'false'
        o[:trackHistory]             = o[:trackHistory]              || 'false'
        o[:required]                 = o[:required]                  || 'false'
        o[:precision]                = o[:precision]                 || '18'
        o[:scale]                    = o[:scale]                     || '2'
        o[:unique]                   = o[:unique]                    || 'false'
        """
  <fields>
    <fullName>#{name_title.gsub(/\s/, '_')}__c</fullName>
    <description>#{name_title} Description</description>
    <externalId>#{o[:externalId]}</externalId>
    <label>#{name_title}</label>
    <required>#{o[:required]}</required>
    <precision>#{o[:precision]}</precision>
    <scale>#{o[:scale]}</scale>
    <trackHistory>#{o[:trackHistory]}</trackHistory>
    <unique>#{o[:unique]}</unique>
    <type>Number</type>
  </fields>
        """
      end
    end
  end
end