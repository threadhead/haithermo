require 'test/test_helper'

class TestTimestampAttribute < Test::Unit::TestCase
  class AAA
    extend HAIthermo::TimestampAttribute
    attr_timestamped(:mickey_mouse, :donald_duck)
  end
    
  def setup
    @aaa = AAA.new
  end
  
  def test_attribute_created
    @aaa.mickey_mouse = 'mouse'
    assert_equal('mouse', @aaa.mickey_mouse)
    @aaa.donald_duck = 'duck'
    assert_equal('duck', @aaa.donald_duck)
  end
  
  def test_attribute_with_timestamp
    @aaa.mickey_mouse = 'mouse'
    assert_equal(Time.now.to_s, @aaa.mickey_mouse_timestamp.to_s)
    # sleep 2
    # assert_not_equal(Time.now.to_s, @aaa.mickey_mouse_timestamp.to_s)
    @aaa.mickey_mouse = 'rat'
    assert_equal('rat', @aaa.mickey_mouse)
    assert_equal(Time.now.to_s, @aaa.mickey_mouse_timestamp.to_s)
  end
end