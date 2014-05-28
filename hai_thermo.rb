require File.join(File.dirname(__FILE__), 'lib', 'control')
require File.join(File.dirname(__FILE__), 'lib', 'logger')
require File.join(File.dirname(__FILE__), 'lib', 'temperature_conversion')
# require 'lib/control'
# require 'lib/logger'
# require 'lib/temperature_conversion'

module  HAIthermo

  VERSION = "0.0.1"

  def self.version
    VERSION
  end

end

