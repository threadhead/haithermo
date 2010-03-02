module HAIthermo
  module Thermostat
    class RegisterError < StandardError; end
  
    class Register
      def initialize(address)
        initialize_registers
        create_accessors
        set_value(0, address)
      end
      
      def create_accessors
        @registers.each_with_index do |register, idx|
          # self.instance_eval do
            self.class.send(:define_method, "#{register[:name]}", proc{ self.get_value( "#{idx}".to_i ) })
            self.class.send(:define_method, "#{register[:name]}=", proc{ |value| self.set_value( "#{idx}".to_i, value ) })
          # end
        end
      end
    
    
      def set_value(register, value)
        # puts "set_value: #{register}, #{value}"
        self.validate_register_limits(register, value)
        @registers[register][:value] = value
        @registers[register][:updated_at] = Time.new
      end
      
      def set_value_range(start_register, values)
        start_register -= 1
        values.each do |value|
          self.set_value( (start_register += 1), value )
        end
      end
      
      def set_value_range_string(string)
        string_bytes = string.bytes.to_a
        self.set_value_range( string_bytes[0], string_bytes[1, 100])
      end
          
          
          
      def get_value(register)
        # puts "geting_register_value: #{register}"
        self.validate_register_range(register)
        @registers[register][:value]
      end
      
      def get_value_range(start_register, quantity)
        start_register -= 1
        arr = []
        quantity.times do
          arr << self.get_value( start_register += 1 )
        end
        arr
      end
      
      def get_value_range_string(start_register, quantity)
        str = start_register.chr
        self.get_value_range(start_register, quantity).each{ |value| str << value.chr }
        str
      end
      
      def limits(register)
        @registers[register][:limits]
      end
      
      
      
      def get_name(register)
        self.validate_register_range(register)
        self.humanize( @registers[register][:name] )
      end
      
      
      def get_updated_at(register)
        self.validate_register_range(register)
        @registers[register][:updated_at]
      end


      def register_names
        @registers.map { |register| register[:name] }
      end
    
    
      def validate_register_limits(register, value)
        self.validate_register_range(register)
        
        limits = @registers[register][:limits]
        unless limits.include?( value )
          raise RegisterError.new("register '#{self.get_name(register)}' not within allowable value range #{limits}")
        end      
      end
      
      
      def validate_register_range(register)
        if register < 0 || register > ( @registers.size - 1 )
          raise RegisterError.new("register '#{register}' is not a valid register")
        end
      end
      
      
      def dump
        puts "--- ALL REGISTER VALUES ---"
        @registers.map { |r| puts "name: #{r[:name]}, value: #{r[:value]}" }
      end
      
      
      # sorta from ActiveSupport
      def humanize(string)
        string.gsub(/_/, " ").gsub(/\b('?[a-z])/) { $1.upcase }
      end
    
    
    
      private
      def initialize_registers
        @registers = [
                      { :name => 'address', :limits => (1..127) },
                      { :name => 'communication_mode', :limits => [0, 1, 8, 24] },
                      { :name => 'system_options', :limits => (0..127) },
                      { :name => 'display_options', :limits => (0..127) },
                      { :name => 'calibration_offset', :limits => (0..59) },
                      { :name => 'cool_setpoint_low_limit', :limits => (0..255) },
                      { :name => 'heat_setpoint_high_limit', :limits => (0..255) },
                      { :name => 'reserved', :limits => [] },
                      { :name => 'reserved', :limits => [] },
                      { :name => 'cooling_anticipator', :limits => (0..30) },
                      { :name => 'heating_anticipator', :limits => (0..30) },
                      { :name => 'cooling_cycle_time', :limits => (2..30) },
                      { :name => 'heating_cycle_time', :limits => (2..30) },
                      { :name => 'aux_heat_diff', :limits => (0..127) },
                      { :name => 'clock_adjust', :limits => (1..59) },
                      { :name => 'days_remaining_filter_reminder', :limits => (0..127) },
                      { :name => 'system_run_time_current_week', :limits => (0..127) },
                      { :name => 'system_run_time_last_week', :limits => (0..127) },
                    
                        #only used in models with real time pricing
                      { :name => 'real_time_pricing_setback', :limits => (0..127) },
                      { :name => 'high', :limits => (0..127) },
                      { :name => 'critical', :limits => (0..127) },
                    
                        # programming registers
                      { :name => 'weekday_morning_time', :limits => (0..96) },
                      { :name => 'weekday_morning_cool_setpoint', :limits => (0..255) },
                      { :name => 'weekday_morning_heat_setpoint', :limits => (0..255) },
                      { :name => 'weekday_day_time', :limits => (0..96) },
                      { :name => 'weekday_day_cool_setpoint', :limits => (0..255) },
                      { :name => 'weekday_day_heat_setpoint', :limits => (0..255) },
                      { :name => 'weekday_evening_time', :limits => (0..96) },
                      { :name => 'weekday_evening_cool_setpoint', :limits => (0..255) },
                      { :name => 'weekday_evening_heat_setpoint', :limits => (0..255) },
                      { :name => 'weekday_night_time', :limits => (0..96) },
                      { :name => 'weekday_night_cool_setpoint', :limits => (0..255) },
                      { :name => 'weekday_night_heat_setpoint', :limits => (0..255) },

                      { :name => 'saturday_morning_time', :limits => (0..96) },
                      { :name => 'saturday_morning_cool_setpoint', :limits => (0..255) },
                      { :name => 'saturday_morning_heat_setpoint', :limits => (0..255) },
                      { :name => 'saturday_day_time', :limits => (0..96) },
                      { :name => 'saturday_day_cool_setpoint', :limits => (0..255) },
                      { :name => 'saturday_day_heat_setpoint', :limits => (0..255) },
                      { :name => 'saturday_evening_time', :limits => (0..96) },
                      { :name => 'saturday_evening_cool_setpoint', :limits => (0..255) },
                      { :name => 'saturday_evening_heat_setpoint', :limits => (0..255) },
                      { :name => 'saturday_night_time', :limits => (0..96) },
                      { :name => 'saturday_night_cool_setpoint', :limits => (0..255) },
                      { :name => 'saturday_night_heat_setpoint', :limits => (0..255) },
                      
                      { :name => 'sunday_morning_time', :limits => (0..96) },
                      { :name => 'sunday_morning_cool_setpoint', :limits => (0..255) },
                      { :name => 'sunday_morning_heat_setpoint', :limits => (0..255) },
                      { :name => 'sunday_day_time', :limits => (0..96) },
                      { :name => 'sunday_day_cool_setpoint', :limits => (0..255) },
                      { :name => 'sunday_day_heat_setpoint', :limits => (0..255) },
                      { :name => 'sunday_evening_time', :limits => (0..96) },
                      { :name => 'sunday_evening_cool_setpoint', :limits => (0..255) },
                      { :name => 'sunday_evening_heat_setpoint', :limits => (0..255) },
                      { :name => 'sunday_night_time', :limits => (0..96) },
                      { :name => 'sunday_night_cool_setpoint', :limits => (0..255) },
                      { :name => 'sunday_night_heat_setpoint', :limits => (0..255) },
                    
                      { :name => 'reserved', :limits => [] },
                    
                      { :name => 'day_of_week', :limits => (0..6) },
                      { :name => 'cool_setpoint', :limits => (0..255) },
                      { :name => 'heat_setpoint', :limits => (0..255) },
                      { :name => 'thermostat_mode', :limits => (0..4) },
                      { :name => 'fan_status', :limits => (0..1) },
                      { :name => 'hold', :limits => [0, 255] },
                    
                      { :name => 'actual_temperature', :limits => (0..255) },
                      { :name => 'seconds', :limits => (0..59) },
                      { :name => 'minutes', :limits => (0..59) },
                      { :name => 'hours', :limits => (0..23) },
                      { :name => 'outside_temperature', :limits => (0..255) },
                      { :name => 'reserved', :limits => [] },
                      { :name => 'real_time_pricing_mode', :limits => (0..3) },
                      { :name => 'current_mode', :limits => (0..2) },
                      { :name => 'output_status', :limits => (0..255) },
                      { :name => 'model_of_thermostat', :limits => (0..255) }
                      ]
        timestamp = Time.new
        @registers.each do |reg|
          reg.merge!({ :value => 0, :updated_at => timestamp })
        end
      end
    end
  end
end
