module HAIthermo
  module Thermostat
    module Register
      
      class FanStatus < Base
        MODES = %w(auto on)
        
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def status
          MODES[@value]
        end
        
        def status=(status)
          @value = MODES.index(status.to_s)
        end
        
        
        def auto
          self.status = 'auto'
        end
        
        def auto?
          self.status == 'auto'
        end
        


        def on
          self.status = 'on'
        end
        
        def on?
          self.status == 'on'
        end
        
      end
    end
  end
end