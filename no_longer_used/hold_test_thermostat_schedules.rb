require 'test/test_helper'

class TestThermostatSchedues < Test::Unit::TestCase
  def setup
    @control = HAIthermo::Control.new(:debug => true)
    @thermostats = @control.add_thermostat(1)

    @test_methods = Array.new
    days_of_week = %w( weekday saturday sunday )
    times_of_day = %w( morning day evening night )
    days_of_week.each do |dow|
      times_of_day.each do |tod|
        @test_methods << "#{dow}_#{tod}_time"
        @test_methods << "#{dow}_#{tod}_cool_setpoint"
        @test_methods << "#{dow}_#{tod}_heat_setpoint"
      end
    end
    
  end
  
  def test_all_schedule_methods_created
    @test_methods.each do |method|
      assert HAIthermo::Thermostat::Base.method_defined?( method )
    end
  end
  
  def test_weekday_schedules_read_registers
    @thermostats[0].registers.set_value_range(0x15, (31..42).to_a)
    counter = 30
    @test_methods[0, 12].each do |method|
      assert_equal( (counter += 1), @thermostats[0].send( method ) ) 
    end
  end

  def test_saturday_schedules_read_registers
    @thermostats[0].registers.set_value_range(0x21, (41..52).to_a)
    counter = 40
    @test_methods[12, 12].each do |method|
      assert_equal( (counter += 1), @thermostats[0].send( method ) ) 
    end
  end

  def test_sunday_schedules_read_registers
    @thermostats[0].registers.set_value_range(0x2D, (51..62).to_a)
    counter = 50
    @test_methods[24, 12].each do |method|
      assert_equal( (counter += 1), @thermostats[0].send( method ) ) 
    end
  end
end
