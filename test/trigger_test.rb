require 'test_helper'
require 'apexgen/trigger'
require 'active_support/inflector'

class DefaultTest < Test::Unit::TestCase

  def setup
    @name = "TestTrigger"
    @target_object = "CustomObject"
    @events_params = ['before:insert,update', 'after:insert,update']
    @events_parsed = 'before insert, before update, after insert, after update'
    @trigger = Apexgen::Trigger.new @name, @target_object, @events_params
  end

  def teardown
    @name, @target_object, @events, @trigger = nil
  end

  def test_can_initialize
    assert_equal "Apexgen::Trigger", @trigger.class.to_s, "Should be an instance of the correct class"
    assert_equal @name, @trigger.name, "Should automatically set name if passed during initialization"
    assert_equal @target_object, @trigger.target_object, "Should automatically set target_object if passed during initialization"
    assert_equal @events_parsed, @trigger.events, "Should automatically set events if passed during initialization"
  end

  def test_can_parse_event_params
    # array[0] = input array[1] = expected output
    single_param        = [['before:insert'], 'before insert']
    multi_param         = [['before:insert', 'before:update', 'after:insert'], 'before insert, before update, after insert']
    single_param_concat = [['before:insert,update,delete'], 'before insert, before update, before delete']
    multi_param_concat  = [
      ['before:insert,update,delete', 'after:insert,update,delete,undelete'], 
      'before insert, before update, before delete, after insert, after update, after delete, after undelete'
    ]
    invalid_param       = [['before:insert,update,upton'], 'before insert, before update']

    tests = ['single_param', 'multi_param', 'single_param_concat', 'multi_param_concat', 'invalid_param']

    trigger = Apexgen::Trigger.new

    tests.each do |test_name|
      test = eval(test_name)
      test_name = test_name.titleize
      input, expected = test
      trigger.events = input
      assert_equal expected, trigger.events, "Should be able to parse #{test_name}"
    end

  end
end
