module HAIthermo
  module Thermostat
    module Register
      
      class ReadTimePricingMode < Base
        MODES = %w(low mid high critical)
        
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def mode
          MODES[@value]
        end
        
        def mode=(mode)
          @value = MODES.index(mode.to_s)
        end
        
        
        def low
          self.mode = :low
        end
        
        def low?
          self.mode == 'low'
        end
                
        
        def mid
          self.mode = :mid
        end
        
        def mid?
          self.mode == 'mid'
        end
        
        
        def high
          self.mode = :high
        end
        
        def high?
          self.mode == 'high'
        end
        
        
        def critical
          self.mode = :critical
        end
        
        def critical?
          self.mode == 'critical'
        end
        
        
      end
    end
  end
end