module HAIthermo
  class << self; attr_accessor :loggers; end
  
  self.loggers = []

  def self.log_info(message)
    HAIthermo.loggers.each{ |logger| logger.info message }
  end
  
  def self.log_debug(message)
    HAIthermo.loggers.each{ |logger| logger.debug message }
  end

  def self.logger=(logger)
    HAIthermo.loggers = Array(logger)
  end

end