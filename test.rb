require 'hai_thermo'
require 'pp'

puts HAIthermo.version

sp = HAIthermo::Control.new(:debug => true)
sp.open
sp.add_thermostat(1)
sp.get_thermostat(1).get_model

puts "model: #{sp.get_thermostat(1).registers.model_of_thermostat}"

sp.get_thermostat(1).get_limits

puts "cool_setpoint_low_limit: #{sp.get_thermostat(1).registers.cool_setpoint_low_limit}"
puts "heat_setpoint_high_limit: #{sp.get_thermostat(1).registers.heat_setpoint_high_limit}"
