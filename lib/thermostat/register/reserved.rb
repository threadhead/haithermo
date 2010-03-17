module HAIthermo
  module Thermostat
    module Register
      
      class Reserved < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
      end
    end
  end
end