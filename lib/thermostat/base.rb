require 'lib/thermostat/register'
require 'lib/thermostat/schedule'
require 'lib/thermostat/timestamp_attribute'

module HAIthermo
  module Thermostat
    class BaseError < StandardError; end
  
    class Base
      def initialize(address)
        @registers = HAIthermo::Thermostat::Register.new(address)
        @schedules = []
      end
    
    
      def address
        @registers.get_value(0)
      end
      
      def method_name
        
      end
      def update_basic_stats
        # requests groupt 1 data
      end
    
    
    
      def add_schedule(day_of_week, time_of_day, set_time, cool_setpoint, heat_setpoint)
        @schedules << ThermostatSchedule.new(day_of_week, time_of_day, set_time, cool_setpoint, heat_setpoint)
      end
    
      def get_schedule(day_of_week, time_of_day)
        @schedules.detect{ |s| s.day_of_week == day_of_week && s.time_of_day == time_of_day }
      end
    
      def destroy_schedule(day_of_week, time_of_day)
        @schedules.delete_if{ |s| s.day_of_week == day_of_week && s.time_of_day == time_of_day }
      end
    
    
    
      def set_register_value(register, value)
        self.instance_variable_set( "@#{@registers[register.to_s]}", value )
      end

      def get_register_value(register)
        self.instance_variable_get( "@#{@registers[register.to_s]}" )
      end
    
    
    
      def get_model_name
        case self.model
        when 0 then "RC-80"
        when 1 then "RC-81"
        when 8 then "RC-90"
        when 9 then "RC-91"
        when 16 then "RC-100"
        when 17 then "RC-101"
        when 34 then "RC-112"
        when 48 then "RC-120"
        when 49 then "RC-121"
        when 50 then "RC-122"
        end
      end


    
      def self.to_c(omnistat_temp)
        -40.0 + ( omnistat_temp * 0.5 )
      end
    
      def self.to_f(omnistat_temp)
        32 + ( 9.0 / 5 ) * omnistat_temp.to_c      
      end
    

    end
  end
end