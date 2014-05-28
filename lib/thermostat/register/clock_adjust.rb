module HAIthermo
  module Thermostat
    module Register
      
      class ClockAdjust < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def seconds_per_day
          @value - 30
        end
        
        def seconds_per_day_s(seconds=" seconds")
          case self.seconds_per_day
          when 0
            pre = ''
          when 1..29
            pre = '+'
          when -1..-29
            pre = '-'
          end
          
          "#{pre}#{self.seconds_per_day}" + seconds          
        end
        
        def seconds_per_day=(seconds)
          @value = seconds + 30
        end
      end
    end
  end
end