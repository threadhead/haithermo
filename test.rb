require 'hai_thermo'
require 'pp'
# require 'logger'

puts HAIthermo.version

sp = HAIthermo::Control.new(:debug => true,
                            :log_file => File.join(File.dirname(__FILE__), 'haithermo.log'),
                            :log_level => Logger::DEBUG )
sp.open
sp.add_thermostat(1)
sp.thermostat(1).get_model
sp.thermostat(1).get_limits
sp.thermostat(1).get_filter_and_runtimes
sp.thermostat(1).get_setpoints
sp.thermostat(1).get_mode_status
sp.thermostat(1).get_display_options
sp.thermostat(1).get_weekday_schedule
sp.thermostat(1).get_saturday_schedule
sp.thermostat(1).get_sunday_schedule

sp.thermostat(1).registers.dump



# puts "model: #{sp.thermostat(1).registers.model_of_thermostat}"
# 
# 
# puts "cool_setpoint_low_limit: #{sp.thermostat(1).registers.cool_setpoint_low_limit}"
# puts "heat_setpoint_high_limit: #{sp.thermostat(1).registers.heat_setpoint_high_limit}"

sp.close