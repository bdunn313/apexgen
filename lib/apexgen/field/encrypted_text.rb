require 'active_support/inflector'

module Apexgen
  module Field
    class EncryptedText
      def format(name, o={})
        # Set up default opts
        o[:externalId]   = o[:externalId]   || 'false'
        o[:length]       = o[:length]       || '128'
        o[:required]     = o[:required]     || 'false'
        o[:trackHistory] = o[:trackHistory] || 'false'
        o[:maskChar] = o[:maskChar] || 'asterisk'
        o[:maskType] = o[:maskType] || 'all'
        # Titleize the name so we don't need to repeat the method several times
        name_title = name.titleize
        """
  <fields>
    <fullName>#{name_title.gsub(/\s/, '_')}__c</fullName>
    <description>#{name_title} Description</description>
    <externalId>#{o[:externalId]}</externalId>
    <label>#{name_title}</label>
    <length>#{o[:length]}</length>
    <maskChar>#{o[:maskChar]}</maskChar>
    <maskType>#{o[:maskType]}</maskType>
    <required>#{o[:required]}</required>
    <trackHistory>#{o[:trackHistory]}</trackHistory>
    <type>EncryptedText</type>
  </fields>
        """
      end
    end
  end
end