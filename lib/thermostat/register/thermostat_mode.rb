module HAIthermo
  module Thermostat
    module Register
      
      class ThermostatMode < Base
        MODES = %w(off heat cool auto emergency\ heat)
        
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def mode
          MODES[@value]
        end
        
        def mode=(day)
          @value = MODES.index(day.to_s)
        end
        
        
        def off
          self.mode = 'off'
        end
        
        def off?
          self.mode == 'off'
        end
                
        
        def heating
          self.mode = 'heat'
        end
        
        def heat
          self.heating
        end
        
        def heating?
          self.mode == 'heat'
        end
        
        
        def cooling
          self.mode = 'cool'
        end
        
        def cool
          self.cooling
        end
        
        def cooling?
          self.mode == 'cool'
        end
        
        
        def auto
          self.mode = 'auto'
        end
        
        def auto?
          self.mode == 'auto'
        end
        
        
      end
    end
  end
end