module HAIthermo
  module Thermostat
    module Register
      
      class DayOfWeek < Base
        DAYSOFWEEK = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def wday
          DAYSOFWEEK[@value]
        end
        
        def wday=(day)
          @value = DAYSOFWEEK.index(day.to_s)
        end
        
      end
    end
  end
end