require 'hai_thermo'
require 'pp'
require 'logger'

puts HAIthermo.version

sp = HAIthermo::Control.new

logger = Logger.new(File.join(File.dirname(__FILE__), 'haithermo.log'))
logger.level = Logger::DEBUG
logger.formatter = proc { |severity, datetime, progname, msg|
    "[#{datetime.strftime("%d %b%y %H:%M:%S.%2N")}] #{msg}\n"
  }
sp.logger << logger

sp.logger << Logger.new($stdout)

sp.open
sp.add_thermostat(1)
puts HAIthermo::Thermostat::Base.instance_methods.sort
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