module HAIthermo
  module Thermostat  
    module Actions
      
      def get_initial_information
        get_model
        get_limits
        get_filter_and_runtimes
        get_setpoints
        get_mode_status
        get_display_options
      end
      
      def get_schedules
        get_weekday_schedule
        get_saturday_schedule
        get_sunday_schedule
        get_day_of_week
      end
      
      def poll
        get_filter_and_runtimes
        get_setpoints
        get_mode_status
        get_display_options
      end
      
      
      
      def get_filter_and_runtimes
        self.get_registers_from_thermo( 0x0F, 3 )
      end

      def get_setpoints
        self.get_registers_from_thermo( 0x3B, 6 )
      end

      def get_mode_status
        self.get_registers_from_thermo( 0x47, 2 )
      end

      def get_display_options
        self.get_registers_from_thermo( 0x03, 1 )
      end

      def self.get_model
        self.get_registers_from_thermo( 0x49, 1 )
      end

      def get_limits
        self.get_registers_from_thermo( 0x05, 2 )
      end

      def get_weekday_schedule
        self.get_registers_from_thermo( 0x15, 12)
      end

      def get_saturday_schedule
        self.get_registers_from_thermo( 0x21, 12)
      end

      def get_sunday_schedule
        self.get_registers_from_thermo( 0x2D, 12)
      end
      
      def get_day_of_week
        self.get_registers_from_thermo( 0x3A, 1)
      end





      def set_outside_temp_c(temp_c)
        @my_control.send( SetRegisters.new( self.address, 0x44, self.c_to_omnistat( temp_c )).assemble_packet )
      end

      def set_outside_temp_f(temp_f)
        self.set_outside_temp_c( self.f_to_c( temp_f ))
      end

      def set_time
        time = Time.now
        hours, minutes, seconds = time.hour.chr, time.min.chr, time.sec.chr
        @my_control.send( SetRegisters.new( self.address, 0x41, seconds + minutes + hours ))
      end
    end
  end
end