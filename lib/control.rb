require 'rubygems'
# require 'pp'
# require 'serialport'
# Kernel::require 'serialport'


begin
  require 'serialport'
rescue
    Kernel::require 'serialport'
end

module  HAIthermo
  %w(thermostat message_factory).each do |file|
    require File.join(File.dirname(__FILE__), "#{file}")
  end
 
 
  class Control
    attr_accessor :loggers
    
    #the port settings are fixed and should not be changes per HAI Thermostats API
    BAUD_RATE = 300
    DATA_BITS = 8
    STOP_BITS = 1
    PARITY = SerialPort::NONE
    

    def initialize(options={})
      @loggers = Array(options[:logger])
      # @debug = options[:debug] ? options[:debug] : false
      @thermostats = []
    end
    

    def open(port="/dev/ttyS0")
      HAIthermo.logger.info "OPEN SERIAL PORT (#{port}, #{BAUD_RATE}, #{DATA_BITS}, #{STOP_BITS}, #{PARITY})"
      @sp = SerialPort.new(port, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)
      @sp.read_timeout = 100
      # puts 'read_timeout: ' + @sp.read_timeout.to_s
    end

    def close
      HAIthermo.logger.info "CLOSE SERIAL PORT"
      @sp.close if @sp
    end



    def add_thermostat(address)
      @thermostats << HAIthermo::Thermostat::Base.new(self, address)
    end
    
    def thermostat(address)
      @thermostats.detect{ |thermo| thermo.address == address }
    end
    
    def thermostats(message, *args)
      @thermostats.each{ |thermo| thermo.send(message, *args) }
    end
    
    def destroy_thermostat(address)
      @thermostats.delete_if{ |thermo| thermo.address == address }
    end



    def send(send_string)
      self.log_debug ">>> #{MessageFactory.to_hex_string send_string}"
      @sp.write send_string
      sleep(0.2)
    end

    def read
      buffer = ""
      begin
        get_buffer = @sp.gets
        unless get_buffer.nil?
          buffer << get_buffer
          # sleep(0.1)
        end
      end until get_buffer.nil?
      self.log_debug "<<< #{MessageFactory.to_hex_string(buffer) unless buffer.nil?}"
      buffer
    end
    
    def log_info(message)
      @loggers.each{ |logger| logger.info message }
    end
    
    def log_debug(message)
      @loggers.each{ |logger| logger.debug message }
    end

    def logger=(logger)
      @loggers = Array(logger)
    end

    
  end
end