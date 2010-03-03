# $:.unshift File.dirname(__FILE__)

module  HAIthermo
    
  VERSION = "0.0.1"
    
  def self.version
    VERSION
  end
  
  # def self.debug_on
  #   @debug = true
  # end
  # 
  # def self.debug_off
  #   @debug = false
  # end
end

require 'lib/control'
