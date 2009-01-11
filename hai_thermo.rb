
module  HAIthermo
  # attr_reader :debug
  attr_accessor :debug
  
  VERSION = "0.0.1"
  @debug = true
  
  # attr_accessor :attr_names
  
  def self.version
    VERSION
  end
  
  def self.debug_on
    @debug = true
  end
  
  def self.debug_off
    @debug = false
  end
end

require 'lib/control'
