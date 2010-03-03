require 'logger'

module HAIthermo
  class << self; attr_accessor :logger; end
  
  module MyLogger
    def self.new(log_file, level = Logger::DEBUG)
      if log_file
        HAIthermo.logger = Logger.new(log_file)
      else
        HAIthermo.logger = Logger.new(STDOUT)
      end
      HAIthermo.logger.level = level
      HAIthermo.logger.datetime_format = "%d %b %H:%M:%S"
      HAIthermo.logger.formatter = proc { |severity, datetime, progname, msg|
          "[#{datetime}] #{msg}\n"
        }
    end
    
    # def info(message)
    #   HAIthermo.logger.info message 
    # end
    # 
    # def debug(message)
    #   HAIthermo.logger.debug message
    # end
    # 
    # def close
    #   HAIthermo.logger.close
    # end
  end
end