require 'erb'
require 'tilt'

module Apexgen
  class Trigger
    def initialize(name=nil, target_object=nil, trigger_events=nil)
      @template = Tilt.new(File.dirname(__FILE__) + '/templates/trigger.erb')
    end

    def parse_events(raw_params)
      # before:insert,update,delete after:insert,update,delete,undelete
      events = []
      raw_params.each do |param|
        type, actions = param.split ":"
        actions = actions.split ","
        actions.each { |action| events.push "#{type} #{action.strip}" if verify_event(type, action.strip) }
      end
      events.join ", "
    end

    private
    def verify_event(type, action)
      allowed_values = {
        'before' => ['insert', 'update', 'delete'],
        'after'  => ['insert', 'update', 'delete', 'undelete']
      }
      allowed_values[type].include? action
    end
  end
end