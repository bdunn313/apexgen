require 'erb'
require 'tilt'

module Apexgen
  class Trigger
    def initialize(name, target_object, trigger_events)
      @template = Tilt.new('templates/trigger.erb')
    end

    def parse_events(raw_params)
      # before=insert,update,delete after=insert,update,delete,undelete
      events = []
      raw_params.each do |param|
        type, actions = param.split "="
        actions = actions.param.split ","
        actions.each { |action| events.push "#{type} #{action.strip}" }
      end
      events.join ", "
    end
  end
end