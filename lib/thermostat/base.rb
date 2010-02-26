require 'lib/thermostat/register'
require 'lib/thermostat/schedule'
require 'lib/thermostat/timestamp_attribute'

module HAIthermo
  module Thermostat
    class BaseError < StandardError; end
  
    class Base
      def initialize(my_control, address)
        @my_control = my_control
        @registers = HAIthermo::Thermostat::Register.new(address)
        @schedules = []
      end
    
    
      def address
        @registers.get_value(0)
      end
      


      def get_filter_and_runtimes
        self.get_registers( 0x0F, 3 )
      end

      def get_setpoints
        self.get_registers( 0x3B, 6 )
      end
      
      def get_mode_status
        self.get_registers( 0x47, 2 )
      end
      
      def get_display_options
        self.get_registers( 0x03, 1 )
      end
      
      def get_model
        self.get_registers( 0x49, 1 )
      end
      
      def get_limits
        self.get_registers( 0x05, 2 )
      end

      def get_registers( start_register, quantity)
        @my_control.send( PollForRegisters.new( self.address, start_register, quantity ).assemble_packet )
        @my_control.read
      end


      
      def set_outside_temp_c(temp_c)
        @my_control.send SetRegisters.new( self.address, 0x44, self.c_to_omnistat( temp_c )).assemble_packet
      end

      def set_outside_temp_f(temp_f)
        self.set_outside_temp_c( self.f_to_c( temp_f ))
      end

      def set_time
        time = Time.now
        hours, minutes, seconds = time.hour.chr, time.min.chr, time.sec.chr
        @my_control.send( SetRegisters.new( self.address, 0x41, seconds + minutes + hours ))
      end
      
      def display_fahrenheit
        @registers.set_value( 0x03, ( self.bit_set( @registers.get_value( 0x03 ), 0 )))
      end

      def display_celsius
        @registers.set_value( 0x03, ( self.bit_clear( @registers.get_value( 0x03 ), 0 )))
      end
      
      def disply_24h
        @registers.set_value( 0x03, ( self.bit_set( @registers.get_value( 0x03 ), 1 )))
      end
      
      def display_ampm
        @registers.set_value( 0x03, ( self.bit_clear( @registers.get_value( 0x03 ), 1 )))
      end
      
      def display_hide_time_filter
        @registers.set_value( 0x03, ( self.bit_set( @registers.get_value( 0x03 ), 4 )))
      end

      def display_show_time_filer
        @registers.set_value( 0x03, ( self.bit_clear( @registers.get_value( 0x03 ), 4 )))
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
    
    
    
      def model_name
        case @registers.get_value( 0x49 )
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


    
      def omnistat_to_c(temp_o)
        -40.0 + ( temp_o * 0.5 )
      end

      def c_to_omnistat(temp_c)
        ( temp_c + 40 ) * 2
      end
            
      def f_to_c(temp_f)
        ( temp_f - 32 ) * 5 / 9.0
      end
      
      def c_to_f(temp_c)
        ( 9.0 / 5 * temp_c ) + 32.0
      end
    
      def bit_set(byte, bit_to_set)
        byte | ( 2 ** bit_to_set )
      end
      
      def bit_clear(byte, bit_to_clear)
        byte & ((2 ** bit_to_clear) ^ 0b11111111)
      end

    end
  end
end