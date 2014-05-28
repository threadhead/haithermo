require 'rubygems'
require 'minitest/autorun'

require "minitest/reporters"
Minitest::Reporters.use!

require 'pp'
require 'mocha'
require "mocha/mini_test"

# require '../hai_thermo'
require File.join(File.dirname(__FILE__), '..', 'hai_thermo')
