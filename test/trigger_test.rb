require 'test_helper'
require 'apexgen/trigger'
require 'active_support/inflector'

class DefaultTest < Test::Unit::TestCase

  def setup
    
  end

  def teardown
    @trigger = nil
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
      assert_equal expected, trigger.parse_events(input), "Should be able to parse #{test_name}"
    end

  end
end
