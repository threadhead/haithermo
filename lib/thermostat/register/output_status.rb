require 'lib/thermostat/register/fixnum_bits'

module HAIthermo
  module Thermostat
    module Register
      
      class OutputStatus < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end

        def heating?
          @value.bit_get( 0 ) == 1
        end

        def cooling?
          @value.bit_get( 0 ) == 0
        end

        def fan_on?
          @value.bit_get( 3 ) == 1
        end
        
        def fan_off?
          @value.bit_get( 3 ) == 0
        end

        def stage_1_running?
          @value.bit_get( 2 ) == 1
        end
        
        def running?
          self.stage_1_running?
        end
        
        def aux_heat?
          @value.bit_get( 1 ) == 1
        end
        
        def stage_2_running?
          @value.bit_get( 4 ) == 1
        end


        def heating_or_cooling?
          if self.running?
            self.heating? ? 'heating' : 'cooling'
          else
            'off'
          end
        end
        
        def status
          self.heating_or_cooling?
        end

      end
    end
  end
end