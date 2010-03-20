module HAIthermo
  module Thermostat
    module Register
      
      class CurrentMode < ReadOnly
        MODES = %w(off heat cool)
        
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def mode
          MODES[@value]
        end        
        
        
        def off?
          self.mode == 'off'
        end
                
                
        def heat?
          self.mode == 'heat'
        end
        
        def heating?
          self.heat?
        end
        
        
        def cool?
          self.mode == 'cool'
        end
        
        def cooling?
          self.cool?
        end     
        
      end
    end
  end
end