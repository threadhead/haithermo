module HAIthermo
  module Thermostat
    module Register
      
      # A class to hold temperatures and handle conversion
      class Temperature < Base
        attr_accessor :default_scale

        def initialize(number, name, limits, temp=0, scale="omni")
          super(number, name, limits)
          # puts "temp_o: #{temp}, scale: #{scale.to_s[0].downcase}"
          
          case scale.to_s[0].downcase
          when 'c'
            @temp_c = temp
            @value = c_to_omnistat(temp)
          when 'f'
            @temp_f = temp
            @value = c_to_omnistat( f_to_c(temp) )
          # when 'k'
          #   @temp_k = temp
          when 'o'
            @value = temp
          end
        end


        def to_f
          @temp_f ||= omnistat_to_f( @value)
        end
        
        def f
          self.to_f
        end
        
        def farenheit
          self.to_f
        end


        def to_c
          @temp_c ||= omnistat_to_c( @value )
        end
        
        def c
          self.to_c
        end
        
        def celcius
          self.to_c
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


        def to_s(degree_sym='')
          case @default_scale[0].downcase
          when 'c'
            to_s_c(degree_sym)
          when 'f'
            to_s_f(degree_sym)
          when 'o'
            to_s_o(degree_sym)
          else
            to_s_f(degree_sym)
          end
        end


        def to_s_f(degree_sym='')
          sprintf( "%d", to_f ) + degree_sym + 'F'
        end

        def to_s_c(degree_sym='')
          sprintf( "%#.1f", to_c ) + degree_sym + 'C'
        end

        def to_s_o(degree_sym='')
          sprintf( "%d", @value ) + degree_sym + 'Omni'
        end



        def omnistat_to_c(temp_o)
          -40.0 + ( temp_o * 0.5 )
        end

        def omnistat_to_f(temp_o)
          self.c_to_f( self.omnistat_to_c(temp_o) )
        end

        def c_to_omnistat(temp_c)
          (( temp_c + 40 ) * 2).to_i
        end

        def f_to_c(temp_f)
          (( temp_f - 32 ) * 5 / 9.0).round(1)
        end

        def c_to_f(temp_c)
          (( 9.0 / 5 * temp_c ) + 32.0).round
        end

      end
      
    end
  end
end