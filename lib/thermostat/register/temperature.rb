require 'lib/temperature_conversion'

module HAIthermo
  module Thermostat
    module Register
      
      # A class to hold temperatures and handle conversion
      class Temperature < Base
        attr_accessor :default_scale
        include HAIthermo::TempConv

        def initialize(number, name, limits, temp=0, scale="omni")
          super(number, name, limits)
          
          case scale.to_s[0].downcase
          when 'c'
            @value = c_to_omnistat(temp)
          when 'f'
            @value = c_to_omnistat( f_to_c(temp) )
          # when 'k'
          #   @temp_k = temp
          when 'o'
            @value = temp
          end
        end


        def to_f
          omnistat_to_f( @value)
        end
        
        def f
          self.to_f
        end
        
        def fahrenheit
          self.to_f
        end
        
        # because people can't spell fahrenheit!
        def farenheit
          self.to_f
        end

        def f=(temp_f)
          @value = c_to_omnistat( f_to_c(temp_f))
        end
        
        def fahrenheit=(temp_f)
          self.f = temp_f
        end
        
        # because people can't spell fahrenheit!
        def farenheit=(temp_f)
          self.f = temp_f
        end



        def to_c
          omnistat_to_c( @value )
        end
        
        def c
          self.to_c
        end
        
        def celsius
          self.to_c
        end
        
        # becuase people can't spell celsius!
        def celcius
          self.to_c
        end
        
        def c=(temp_c)
          @value = c_to_omnistat(temp_c)
        end
        
        def celsius=(temp_c)
          self.c = temp_c
        end
        
        def celcius=(temp_c)
          self.c = temp_c
        end
        
        
        
        def to_o
          @value
        end
        
        def o
          @value
        end
        
        def omni
          @value
        end
        
        def o=(temp_o)
          @value = temp_o
        end
        
        def omni=(temp_o)
          self.o = temp_o
        end



        def to_s(degree_sym='')
          case @default_scale[0].downcase
          when 'c'
            c_formatted(to_c, degree_sym)
          when 'f'
            f_formatted(to_f, degree_sym)
          when 'o'
            o_formatted(to_o, degree_sym)
          else
            f_formatted(to_f, degree_sym)
          end
        end


      end
      
    end
  end
end