module HAIthermo
  module Thermostat
    module Register
      
      class OutputStatus < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
      end
    end
  end
end