require 'hai_thermo'
require 'pp'

puts HAIthermo.version

sp = HAIthermo::Control.new(:debug => true)

sp.add_thermostat(0)
sp.add_thermostat(1)
pp sp.get_thermostat(0)
pp sp.get_thermostat(1)
pp sp.get_thermostat(33)