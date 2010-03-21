require 'rubygems'

begin
  require 'serialport'
rescue
    Kernel::require 'serialport'
end

module  HAIthermo
  %w(thermostat message message_factory).each do |file|
    require File.join(File.dirname(__FILE__), "#{file}")
  end
   
 
  class Control    
    #the port settings are fixed and should not be changes per HAI Thermostats API
    BAUD_RATE = 300
    DATA_BITS = 8
    STOP_BITS = 1
    PARITY = SerialPort::NONE
    

    def initialize(opts={})
      HAIthermo.loggers = Array(opts[:logger]) if opts[:logger]
      @thermostats = []
    end
    

    def open(port="/dev/ttyS0")
      HAIthermo.log_info "OPEN SERIAL PORT (#{port}, #{BAUD_RATE}, #{DATA_BITS}, #{STOP_BITS}, #{PARITY})"
      @serialport = SerialPort.new(port, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)
      @serialport.read_timeout = 100
      # puts 'read_timeout: ' + @serialport.read_timeout.to_s
    end

    def close
      HAIthermo.log_info "CLOSE SERIAL PORT"
      @serialport.close if @serialport
    end


    def thermostats
      @thermostats
    end

    def add_thermostat(address, name)
      @thermostats << HAIthermo::Thermostat::Base.new(self, address, name)
    end
    
    def thermostat(address)
      @thermostats.detect{ |thermo| thermo.address.value == address }
    end
    
    def thermostats_do(message, *args)
      @thermostats.each{ |thermo| thermo.send(message, *args) }
    end
    
    def destroy_thermostat(address)
      @thermostats.delete_if{ |thermo| thermo.address.value == address }
    end



    def send_packet(packet)
      sent_times = 0
      while sent_times < 4
        begin
          sent_times += 1
          self.send_string(packet.to_s)
          mf = MessageFactory.new.new_incoming_message( self.read_string )
          sent_times = 99 unless mf.kind_of?(Message::ReceiveNACK)
          
        rescue InvalidMessageType, ChecksumError
          # puts $!.inspect
          HAIthermo.log_error($!)
        end        
      end
      
      if sent_times >= 4
        return false
      else
        return mf
      end
      
    # rescue
    #   HAIthermo.log_error($!)
    #   return false
    end


    def send_string(send_string)
      HAIthermo.log_debug "--> #{MessageFactory.to_hex_string send_string}"
      @serialport.write send_string
      sleep(0.2)
    end


    def read_string
      buffer = ""
      begin
        get_buffer = @serialport.gets
        unless get_buffer.nil?
          buffer << get_buffer
          # sleep(0.1)
        end
      end until get_buffer.nil?
      HAIthermo.log_debug "<-- #{MessageFactory.to_hex_string(buffer) unless buffer.nil?}"
      buffer
    end

    
  end
end