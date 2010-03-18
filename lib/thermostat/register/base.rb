require 'time'

module HAIthermo
  module Thermostat
    module Register2
      class RegisterError < StandardError; end
  
      class Base
        attr_accessor :name, :number, :limits, :updated_at
      
        def initialize(number, name, limits)
          @value = 0
          @updated_at = Time.now
          @name = name
          @limits = limits
          @number = number
        end
        
        def value=(value)
          validate_value_limits(value)
          @value = value
          set_timestamp
        end
        
        def value
          @value
        end
        
        def to_hash
          { @name.to_sym  => @value }
        end
        
        
        def set_timestamp
          @updated_at = Time.now
        end
      
      
        def validate_value_limits(value)
          self.validate_number_range
      
          unless @limits.include?( value )
            raise RegisterError.new("register '#{@name}' not within allowable value range #{@limits}")
          end      
        end
      
      
        def validate_number_range
          if @number < 0 || @number > 73
            raise RegisterError.new("register '#{@name}' does not have a valid number (#{@number})")
          end
        end
        
        
        private
        # sorta from ActiveSupport
        def humanize(string)
          string.gsub(/_/, " ").gsub(/\b('?[a-z])/) { $1.upcase }
        end
        
      
      end
      
    end
  end
end