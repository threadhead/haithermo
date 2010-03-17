module HAIthermo
  module Thermostat
    module Registers
      
      class RegisterError < StandardError; end
      
      def self.extended(base)
        base.instance_variable_set(:@registers, Array.new)
      end
      
      def initialize(address)
        create_registers
        create_accessors
        @registers.register_named(:address).value = address
      end
      
      # def [](name)
      #   self.register_named( name.to_s )
      # end
      
      
      def register_named(name)
        idx = @registers.index{ |register| register.name == name.to_s }
        raise RegisterError.new("requested register (#{name}) does not exist") unless idx
        idx
      end
    

      def register_number(number)
        idx = @registers.index{ |register| register.number == number }
        raise RegisterError.new("requested register (#{name}) does not exist") unless idx
        idx
      end


      # def set_value(register, value)
      #   # puts "set_value: #{register}, #{value}"
      #   self.validate_register_limits(register, value)
      #   @registers[register][:value] = value
      #   @registers[register][:updated_at] = Time.new
      # end
    
      def set_value_range(start_register, values)
        start_register -= 1
        values.each do |value|
          # self.set_value( (start_register += 1), value )
          reg = register_number( start_register += 1 )
          @registers[reg].value = value if reg
        end
      end
    
      def set_value_range_string(string)
        string_bytes = string.bytes.to_a
        self.set_value_range( string_bytes[0], string_bytes[1, 100])
      end
    
        
        
        
      # def get_value(register)
      #   # puts "geting_register_value: #{register}"
      #   self.validate_register_range(register)
      #   @registers[register][:value]
      # end
    
      # def get_value_by_name(register_name)
      #   idx = @registers.index{ |reg| reg[:name] == register_name }
      #   @registers[idx][:value] if idx
      # end
    
      def get_value_range(start_register, quantity)
        start_register -= 1
        arr = []
        quantity.times do
          # arr << self.get_value( start_register += 1 )
          reg = self.register_number( start_register += 1 )
          ( arr << @registers[reg].value ) if reg
        end
        arr
      end
    
      def get_value_range_string(start_register, quantity)
        # str = start_register.chr
        str = ""
        self.get_value_range(start_register, quantity).each{ |value| str << value.chr }
        str
      end
    
      # def limits(register)
      #   @registers[register][:limits]
      # end
    
    
    
      # def get_name(register)
      #   self.validate_register_range(register)
      #   self.humanize( @registers[register][:name] )
      # end
    
    
      # def get_updated_at(register)
      #    self.validate_register_range(register)
      #    @registers[register][:updated_at]
      #  end


      def register_names
        @registers.map { |register| register.name }
      end
    
      def register_values_hash
        register_values = { :updated_at  => Time.now }
        @registers.each do |register|
          register_values.merge!( { register.name.to_sym => register.value } )
        end
        return register_values    
      end
  
      
    
      def dump
        puts "--- ALL REGISTER VALUES ---"
        @registers.map { |register| puts "name: #{register.name}, value: #{register.value}" }
      end

  
  
  
      private
      def create_accessors
        @registers.each_with_index do |register|
          # self.instance_eval do
            self.class.send(:define_method, "#{register.name}", proc{ self.register_named("#{register.name}").value })
            self.class.send(:define_method, "#{register.name}=", proc{ |value| self.register_named("#{register.name}").value = value })
          # end
        end
      end
    
    
      def create_registers
        registers = [
                    { :name => 'address', :limits => (1..127) },
                    { :name => 'communication_mode', :limits => [0, 1, 8, 24] },
                    { :name => 'system_options', :limits => (0..127) },
                    { :name => 'display_options', :limits => (0..127) },
                    { :name => 'calibration_offset', :limits => (0..59) },
                    { :name => 'cool_setpoint_low_limit', :limits => (0..255), :type => :temp },
                    { :name => 'heat_setpoint_high_limit', :limits => (0..255), :type => :temp },
                    { :name => 'reserved_07', :limits => [], :type => :reserved },
                    { :name => 'reserved_08', :limits => [], :type => :reserved },
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
                    { :name => 'real_time_pricing_setback_mid', :limits => (0..127) },
                    { :name => 'real_time_pricing_setback_high', :limits => (0..127) },
                    { :name => 'real_time_pricing_setback_critical', :limits => (0..127) },
                
                      # programming registers
                    { :name => 'weekday_morning_time', :limits => (0..255) },
                    { :name => 'weekday_morning_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'weekday_morning_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'weekday_day_time', :limits => (0..255) },
                    { :name => 'weekday_day_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'weekday_day_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'weekday_evening_time', :limits => (0..255) },
                    { :name => 'weekday_evening_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'weekday_evening_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'weekday_night_time', :limits => (0..255) },
                    { :name => 'weekday_night_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'weekday_night_heat_setpoint', :limits => (0..255), :type => :temp },

                    { :name => 'saturday_morning_time', :limits => (0..255) },
                    { :name => 'saturday_morning_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'saturday_morning_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'saturday_day_time', :limits => (0..255) },
                    { :name => 'saturday_day_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'saturday_day_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'saturday_evening_time', :limits => (0..255) },
                    { :name => 'saturday_evening_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'saturday_evening_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'saturday_night_time', :limits => (0..255) },
                    { :name => 'saturday_night_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'saturday_night_heat_setpoint', :limits => (0..255), :type => :temp },
                  
                    { :name => 'sunday_morning_time', :limits => (0..255) },
                    { :name => 'sunday_morning_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'sunday_morning_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'sunday_day_time', :limits => (0..255) },
                    { :name => 'sunday_day_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'sunday_day_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'sunday_evening_time', :limits => (0..255) },
                    { :name => 'sunday_evening_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'sunday_evening_heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'sunday_night_time', :limits => (0..255) },
                    { :name => 'sunday_night_cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'sunday_night_heat_setpoint', :limits => (0..255), :type => :temp },
                
                    { :name => 'reserved_57', :limits => [], :type => :reserved },
                
                    { :name => 'day_of_week', :limits => (0..6) },
                    { :name => 'cool_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'heat_setpoint', :limits => (0..255), :type => :temp },
                    { :name => 'thermostat_mode', :limits => (0..4) },
                    { :name => 'fan_status', :limits => (0..1) },
                    { :name => 'hold', :limits => [0, 255] },
                
                    { :name => 'actual_temperature', :limits => (0..255), :type => :temp },
                    { :name => 'seconds', :limits => (0..59) },
                    { :name => 'minutes', :limits => (0..59) },
                    { :name => 'hours', :limits => (0..23) },
                    { :name => 'outside_temperature', :limits => (0..255), :type => :temp },
                    { :name => 'reserved', :limits => [], :type => :reserved },
                    { :name => 'real_time_pricing_mode', :limits => (0..3) },
                    { :name => 'current_mode', :limits => (0..2) },
                    { :name => 'output_status', :limits => (0..255) },
                    { :name => 'model_of_thermostat', :limits => (0..255) }
                    ]
        
        registers.each_with_index do |register, idx|
          case register[:type]
          when :temp
            @registers << HAIthermo::Thermostat::Register::Temperature.new(idx, register[:name], register[:limits])
          when :reserved
            @registers << HAIthermo::Thermostat::Register::Reserved.new(idx, register[:name], register[:limits])
          when :time
            @registers << HAIthermo::Thermostat::Register::Time.new(idx, register[:name], register[:limits])
          else
            @registers << HAIthermo::Thermostat::Register::Base.new(idx, register[:name], register[:limits])
          end
        end
        
      end
      
      
    end
  end
end
