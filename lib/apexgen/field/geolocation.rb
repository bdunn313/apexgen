require 'active_support/inflector'

module Apexgen
  module Field
    class Geolocation
      def format(name, o={})
        # Titleize the name so we don't need to repeat the method several times
        name_title = name.titleize
        # Set up default opts
        o[:externalId]               = o[:externalId]                || 'false'
        o[:trackHistory]             = o[:trackHistory]              || 'false'
        o[:required]                 = o[:required]                  || 'false'
        o[:displayLocationInDecimal] = o[:displayLocationInDecimal]  || 'false'
        o[:scale]                    = o[:scale]                     || '2'
        """
  <fields>
    <fullName>#{name_title.gsub(/\s/, '_')}__c</fullName>
    <description>#{name_title} Description</description>
    <displayLocationInDecimal>#{o[:displayLocationInDecimal]}</displayLocationInDecimal>
    <externalId>#{o[:externalId]}</externalId>
    <label>#{name_title}</label>
    <required>#{o[:required]}</required>
    <scale>#{o[:scale]}</scale>
    <trackHistory>#{o[:trackHistory]}</trackHistory>
    <type>Location</type>
  </fields>
        """
      end
    end
  end
end