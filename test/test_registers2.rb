require 'rubygems'
require 'test/unit'
require 'pp'
require 'mocha'

# we don't want to load the entire HAIthermo library yet
# require 'test/test_helper'
require 'lib/thermostat/register2'
require 'lib/thermostat/registers2'


class TestRegisters < Test::Unit::TestCase
  def setup
    # @register_module = HAIthermo::Thermostat::Registers
    # @registers = Array.new
  end
  
  def test_extending_registers_into_a_class_instance
    @thermo = Class.new
    @thermo.extend( HAIthermo::Thermostat::Registers )
    @thermo.register_initialize(1)
  end
end