module HAIthermo
  module Thermostat
    module Register
      
      class Model < ReadOnly
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def model_of_thermostat
          self
        end
        
        def model_name
          case self.value
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
        
      end
    end
  end
end