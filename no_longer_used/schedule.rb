require 'lib/thermostat/register_bits'

module HAIthermo
  module Thermostat
    module Schedule
      
      def self.included(into)
        days_of_week = %w( weekday saturday sunday )
        times_of_day = %w( morning day evening night )
        register = 0x14 # register 0x15 - 1 for first increment
        
        days_of_week.each do |dow|
          times_of_day.each do |tod|
            into.class_eval <<CEV
define_method "#{dow}_#{tod}_time" do
  @registers.get_value( "#{register += 1}".to_i )
end

define_method "#{dow}_#{tod}_cool_setpoint" do
  @registers.get_value( "#{register += 1}".to_i )
end

define_method "#{dow}_#{tod}_heat_setpoint" do
  @registers.get_value( "#{register += 1}".to_i )
end
CEV
          end
        end
      end
      
    end
  end
end