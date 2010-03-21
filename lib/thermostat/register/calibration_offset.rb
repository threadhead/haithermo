require 'lib/temperature_conversion'

module HAIthermo
  module Thermostat
    module Register
      
      class CalibrationOffset < Base
        include HAIthermo::TempConv
        
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def degrees
          (@value - 30) * 0.5
        end
        
        def degrees_s(degree_sym='')
          c_formatted(self.degrees, degree_sym)
        end
        
        def degrees=(temp_c)
          @value = (temp_c / 0.5) + 30
        end
      end
    end
  end
end