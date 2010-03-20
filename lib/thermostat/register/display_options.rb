require 'lib/thermostat/register/fixnum_bits'

module HAIthermo
  module Thermostat
    module Register
      
      class DisplayOptions < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        
        def fahrenheit
          @value = @value.bit_set( 0 )
        end
        
        # because people can't spell fahrenheit!
        def farenheit
          self.fahrenheit
        end


        def celsius
          @value = @value.bit_clear( 0 )
        end
        
        # becuase people can't spell celsius!
        def celcius
          self.celsius
        end


        def fahrenheit?
          @value.bit_get(0) == 1
        end

        def celsius?
          @value.bit_get(0) == 0
        end




        def time_24h
          @value = @value.bit_set( 1 )
        end

        def time_ampm
          @value = @value.bit_clear( 1 )
        end

        def time_24h?
          @value.bit_get( 1 ) == 1
        end
        
        def time_ampm?
          @value.bit_get( 1 ) == 0
        end



        def hide_filter_time
          @value = @value.bit_set( 4 )
        end

        def show_filter_time
          @value = @value.bit_clear( 4 )
        end
        
        def filter_time?
          @value.bit_get( 4 ) == 0
        end


        def programmable
          @value = @value.bit_clear( 2 )
        end
        
        def non_programmable
          @value = @value.bit_set( 2 )
        end
        
        def programmable?
          @value.bit_get( 2 ) == 0  
        end


        def rtp_off
          @value = @value.bit_clear( 3 )
        end
        
        def rtp_on
          @value = @value.bit_set( 3 )
        end
        
        def rtp?
          @value.bit_get( 3 ) == 1  
        end
        
      end
    end
  end
end