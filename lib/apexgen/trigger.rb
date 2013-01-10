require 'erb'
require 'tilt'

module Apexgen
  class Trigger
    attr_accessor :name, :target_object
    attr_reader :events

    def initialize(name=nil, target_object=nil, events=nil)
      @name, @target_object = name, target_object
      self.events = events
      @template = Tilt.new(File.dirname(__FILE__) + '/templates/trigger.erb')
    end

    def events=(raw_events)
      return raw_events if raw_events.kind_of? String
      return nil unless raw_events.kind_of? Array
      events = []
      raw_events.each do |param|
        type, actions = param.split ":"
        actions = actions.split ","
        actions.each { |action| events.push "#{type} #{action.strip}" if verify_event(type, action.strip) }
      end
      @events = events.join ", "
    end

    def build(save_now=false)
      @rendered_string = @template.render(self)
      save() if save_now
    end

    def save(dir)
      
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