require 'logger'

module HAIthermo
  class << self; attr_accessor :logger; end
  
  module Logger
    def self.new(file, level = Logger::DEBUG)
      if file
        HAIthermo.logger = Logger.new(log_file)
        HAIthermo.logger.level = level
        HAIthermo.logger.datetime_format = "%d %b %H:%M:%S"
        HAIthermo.logger.formatter = proc { |severity, datetime, progname, msg|
            "[#{datetime}] #{msg}\n"
          }
      end
    end
    
    def info(message)
      HAIthermo.logger.info message 
    end
    
    def debug(message)
      HAIthermo.logger.debug message
    end
    
    def close
      HAIthermo.logger.close
    end
  end
end