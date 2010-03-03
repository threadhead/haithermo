require 'logger'

module HAIthermo
  class << self; attr_accessor :logger; end
  
  module MyLogger
    def self.new(log_file, level = Logger::DEBUG)
      if log_file
        logger = HAIthermo.logger = Logger.new(log_file)
      else
        logger = HAIthermo.logger = Logger.new(STDOUT)
      end
      logger.level = level
      logger.formatter = proc { |severity, datetime, progname, msg|
          "[#{datetime.strftime("%d %b %H:%M:%S.%2N")}] #{msg}\n"
        }
        puts "logger format: #{logger.datetime_format}"
      return logger
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