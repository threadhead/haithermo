module HAIthermo
  module Thermostat  
    module Actions
      # These actions are helpers for complex data sending and requests.

      def get_initial_information
        action_info :get_initial_information
        get_model
        get_limits
        get_filter_and_runtimes
        get_setpoints
        get_mode_status
        get_display_options
      end
      
      def get_schedules
        action_info :get_schedules
        get_weekday_schedule
        get_saturday_schedule
        get_sunday_schedule
        get_day_of_week
      end
      
      def poll
        action_info :poll
        get_filter_and_runtimes
        get_setpoints
        get_mode_status
        get_display_options
      end
      
      
      
      def get_filter_and_runtimes
        action_debug :get_filter_and_runtimes
        self.get_registers_from_thermo( 0x0F, 3 )
      end

      def get_setpoints
        action_debug :get_setpoints
        self.get_registers_from_thermo( 0x3B, 6 )
      end

      def get_mode_status
        action_debug :get_mode_status
        self.get_registers_from_thermo( 0x47, 2 )
      end

      def get_display_options
        action_debug :get_display_options
        self.get_registers_from_thermo( 0x03, 1 )
      end

      def get_model
        action_debug :get_model
        self.get_registers_from_thermo( 0x49, 1 )
      end

      def get_limits
        action_debug :get_limits
        self.get_registers_from_thermo( 0x05, 2 )
      end



      def get_weekday_schedule
        action_debug :get_weekday_schedule
        self.get_registers_from_thermo( 0x15, 12)
      end

      def get_saturday_schedule
        action_debug :get_saturday_schedule
        self.get_registers_from_thermo( 0x21, 12)
      end

      def get_sunday_schedule
        action_debug :get_sunday_schedule
        self.get_registers_from_thermo( 0x2D, 12)
      end
      
      def get_day_of_week
        action_debug :get_day_of_week
        self.get_registers_from_thermo( 0x3A, 1)
      end





      def set_outside_temp_c(temp_c)
        action_info "set_outside_temp_c: #{temp_c}"
        self.outside_temp.c = temp_c
        self.set_outside_temp
      end

      def set_outside_temp_f(temp_f)
        action_info "set_outside_temp_c: #{temp_c}"
        self.outside_temp.f = temp_f
        self.set_outside_temp
      end

      def set_outside_temp
        self.set_registers_from_thermo( 0x44, 1 )
      end



      def set_time
        action_info :set_time
        time = Time.now
        self.hours.value = time.hour.chr
        self.minutes.value = time.min.chr
        self.seconds.value = time.sec.chr
        self.set_registers_from_thermo( 0x41, 3 )
      end



      private
      def action_info(message)
        HAIthermo.log_info( action_message(message) )
      end
      
      def action_debug(message)
        HAIthermo.log_debug( action_message(message) )
      end
      
      def action_message(message)
        "(t:#{self.address}) #{message}"
      end

    end
  end
end