module HAIthermo
  module Thermostat
    class Schedule
      attr_accessor :day_of_week, :time_of_day, :set_time, :cool_setpoint, :heat_setpoint
    
      def initialize(day_of_week, time_of_day, set_time, cool_setpoint, heat_setpoint)
      @days_of_week = %w( weekday saturday sunday )
      @times_of_day = %w( morning day evening night )
    
      raise "day_of_week must be #{@days_of_week.join('/')}" unless @days_of_week.include?(day_of_week)
      raise "time_of_day must be #{@time_of_day.join('/')}" unless @times_of_day.include?(time_of_day)

      @day_of_week = day_of_week
      @time_of_day = time_of_day
      @set_time = set_time
      @cool_setpoint = cool_setpoint
      @heat_setpoint = heat_setpoint  
      end
    end
  end
end