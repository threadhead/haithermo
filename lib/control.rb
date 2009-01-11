# require 'serialport'
Kernel::require "serialport"
require 'pp'

module  HAIthermo
  class Control
    require 'lib/thermostat'
    require 'lib/message'
    
    #the port settings are fixed and should not be changes per HAI Thermostats API
    BAUD_RATE = 300
    DATA_BITS = 8
    STOP_BITS = 1
    PARITY = SerialPort::NONE
    

    def initialize(options={})
      @debug = options[:debug] ? options[:debug] : false
      @thermostats = []
    end
    

    def open(port="/dev/ttyS0")
      @sp = SerialPort.new(port, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)
      @sp.read_timeout = 100
      puts 'read_timeout: ' + @sp.read_timeout.to_s
    end

    def close
      @sp.close if @sp
    end



    def add_thermostat(address)
      @thermostats << Thermostat.new(address)
    end
    
    def get_thermostat(address)
      @thermostats.detect{ |t| t.address == address }
    end
    
    def destroy_thermostat(address)
      @thermostats.delete_if{ |t| t.address == address }
    end



    def send(send_string)
      @sp.puts send_string
      sleep(0.5)
    end

    def read
      buffer = ""
      begin
        get_buffer = @sp.gets
        puts "buffer check: " + (get_buffer.nil? ? "0" : get_buffer.length.to_s)
        unless get_buffer.nil?
          buffer << get_buffer
          # sleep(0.1)
        end
      end until get_buffer.nil?
      buffer
    end

    def pp_hex_to_string(hex_string)
      pp hex_string.split(//).collect{ |s| s.unpack('H*')[0]}
    end

    def debug_on
      @debug = true
    end
    
    def debug_off
      @debug = false
    end

    module ClassMethods
      # def acts_as_commentable
      #   include Juixe::Acts::Commentable::InstanceMethods
      #   extend Juixe::Acts::Commentable::SingletonMethods
      # end
    end

    module SingletonMethods
      #add clss methods here
    end

    module InstanceMethods
      # Add instance methods here
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end