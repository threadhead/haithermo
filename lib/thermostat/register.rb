require 'lib/thermostat/register/base'
require 'lib/thermostat/register/read_only'


Dir["#{File.dirname(__FILE__)}/register/*.rb"].each do |path|
  require "lib/thermostat/register/#{File.basename(path)}"
end
