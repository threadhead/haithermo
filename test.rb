require 'hai_thermo'
require 'pp'

puts HAIthermo.version

sp = HAIthermo::Control.new(:debug => true)
sp.open
sp.add_thermostat(1)
sp.get_thermostat(1).get_model