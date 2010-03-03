require 'logger'

module HAIthermo
  class Logger
    attr_accessor :logger
    def initialize(file, level = Logger::DEBUG)
      @logger = Logger.new(log_file)
      @logger.level = level
      @logger.datetime_format = "%d %b %H:%M:%S"
      @logger.formatter = proc { |severity, datetime, progname, msg|
          "[#{datetime}] #{msg}\n"
        }
    end
    
    def info(message)
      @logger.info message 
    end
    
    def debug(message)
      @logger.debug message
    end
    
    def close
      @logger.close
    end
  end
end