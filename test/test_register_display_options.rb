require_relative 'test_helper'


class TestRegisterDisplayOptions < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::DisplayOptions.new(4, "display_options", (0..127))
  end


  def test_setting_temperature_display
    @register.fahrenheit
    assert_equal(1, @register.value.bit_get(0))
    @register.celsius
    assert_equal(0, @register.value.bit_get(0))

    @register.fahrenheit
    assert_equal(true, @register.fahrenheit?)
    assert_equal(false, @register.celsius?)

    @register.celsius
    assert_equal(false, @register.fahrenheit?)
    assert_equal(true, @register.celsius?)
  end


  def test_setting_time_display
    @register.time_24h
    assert_equal(1, @register.value.bit_get(1))
    @register.time_ampm
    assert_equal(0, @register.value.bit_get(1))

    @register.time_24h
    assert_equal(true, @register.time_24h?)
    assert_equal(false, @register.time_ampm?)

    @register.time_ampm
    assert_equal(false, @register.time_24h?)
    assert_equal(true, @register.time_ampm?)
  end


  def test_setting_filter_display
    @register.hide_filter_time
    assert_equal(1, @register.value.bit_get(4))
    @register.show_filter_time
    assert_equal(0, @register.value.bit_get(4));

    @register.hide_filter_time
    assert_equal(false, @register.filter_time?)
    @register.show_filter_time
    assert_equal(true, @register.filter_time?)
  end


  def test_setting_programmability
    @register.non_programmable
    assert_equal(1, @register.value.bit_get(2))
    @register.programmable
    assert_equal(0, @register.value.bit_get(2));

    @register.non_programmable
    assert_equal(false, @register.programmable?)
    @register.programmable
    assert_equal(true, @register.programmable?)
  end


  def test_setting_real_time_pricing
    @register.rtp_on
    assert_equal(1, @register.value.bit_get(3))
    @register.rtp_off
    assert_equal(0, @register.value.bit_get(3));

    @register.rtp_off
    assert_equal(false, @register.rtp?)
    @register.rtp_on
    assert_equal(true, @register.rtp?)
  end

end
