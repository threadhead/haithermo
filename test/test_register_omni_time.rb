require_relative 'test_helper'


class TestRegisterOmniTime < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::OmniTime.new(0, "morning_cool_time", (0..96))
  end


  def test_converstion_to_time
    @register.value = 1
    assert_equal(Time.local(2000,1,1,0,15,0), @register.time)
    @register.value = 95
    assert_equal(Time.local(2000,1,1,23,45,0), @register.time)
    @register.value = 55
    assert_equal(Time.local(2000,1,1,13,45,0), @register.time)
  end


  def test_setting_omni_time_from_time
    @register.time = Time.local(2000,1,1,0,15,0)
    assert_equal(1, @register.value)
    @register.time = Time.local(2000,1,1,23,45,0)
    assert_equal(95, @register.value)
    @register.time = Time.local(2000,1,1,13,45,0)
    assert_equal(55, @register.value)
  end


  def test_setting_omni_time_from_string
    @register.time = "00:15:00"
    assert_equal(1, @register.value)
    @register.time = "23:45:00"
    assert_equal(95, @register.value)
    @register.time = "13:45:00"
    assert_equal(55, @register.value)
  end


  def test_returning_time_as_string
    @register.value = 1
    assert_equal("00:15", @register.time_s_24h)
    @register.value = 95
    assert_equal("23:45", @register.time_s_24h)
    @register.value = 55
    assert_equal("13:45", @register.time_s_24h)

    @register.value = 1
    assert_equal("12:15am", @register.time_s_12h)
    @register.value = 95
    assert_equal("11:45pm", @register.time_s_12h)
    @register.value = 55
    assert_equal("01:45pm", @register.time_s_12h)
  end

end
