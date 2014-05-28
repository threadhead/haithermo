module HAIthermo
  module TempConv
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




    def f_formatted(temp_f, degree_sym='')
      sprintf( "%d", temp_f ) + degree_sym + 'F'
    end


    def c_formatted(temp_c, degree_sym='')
      sprintf( "%#.1f", temp_c ) + degree_sym + 'C'
    end


    def o_formatted(temp_o, degree_sym='')
      sprintf( "%d", temp_o ) + degree_sym + 'Omni'
    end    
  end
end