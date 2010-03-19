module HAIthermo
  module Thermostat
    class RegisterError < StandardError; end
  
    class Register
      def initialize(address)
        initialize_registers
        create_accessors
        set_value(0, address)
      end
      

      def set_value(register, value)
        # puts "set_value: #{register}, #{value}"
        self.validate_register_limits(register, value)
        @registers[register][:value] = value
        @registers[register][:updated_at] = Time.new
      end
      
      def set_value_range(start_register, values)
        start_register -= 1
        values.each do |value|
          self.set_value( (start_register += 1), value )
        end
      end
      
      def set_value_range_string(string)
        string_bytes = string.bytes.to_a
        self.set_value_range( string_bytes[0], string_bytes[1, 100])
      end
      
          
          
          
      def get_value(register)
        # puts "geting_register_value: #{register}"
        self.validate_register_range(register)
        @registers[register][:value]
      end
      
      def get_value_by_name(register_name)
        idx = @registers.index{ |reg| reg[:name] == register_name }
        @registers[idx][:value] if idx
      end
      
      def get_value_range(start_register, quantity)
        start_register -= 1
        arr = []
        quantity.times do
          arr << self.get_value( start_register += 1 )
        end
        arr
      end
      
      def get_value_range_string(start_register, quantity)
        # str = start_register.chr
        str = ""
        self.get_value_range(start_register, quantity).each{ |value| str << value.chr }
        str
      end
      
      def limits(register)
        @registers[register][:limits]
      end
      
      
      
      def get_name(register)
        self.validate_register_range(register)
        self.humanize( @registers[register][:name] )
      end
      
      
      def get_updated_at(register)
        self.validate_register_range(register)
        @registers[register][:updated_at]
      end


      def register_names
        @registers.map { |register| register[:name] }
      end
      
      def register_values_hash
        register_values = { :updated_at  => Time.now }
        @registers.each do |register|
          register_values.merge!( { register[:name].to_sym => register[:value] } )
        end
        return register_values    
      end
    
    
      def validate_register_limits(register, value)
        self.validate_register_range(register)
        
        limits = @registers[register][:limits]
        unless limits.include?( value )
          raise RegisterError.new("register '#{self.get_name(register)}' not within allowable value range #{limits}")
        end      
      end
      
      
      def validate_register_range(register)
        if register < 0 || register > ( @registers.size - 1 )
          raise RegisterError.new("register '#{register}' is not a valid register")
        end
      end
      
      
      def dump
        puts "--- ALL REGISTER VALUES ---"
        @registers.map { |r| puts "name: #{r[:name]}, value: #{r[:value]}" }
      end
      
      
      # sorta from ActiveSupport
      def humanize(string)
        string.gsub(/_/, " ").gsub(/\b('?[a-z])/) { $1.upcase }
      end
    
    
    
      private
      def create_accessors
        @registers.each_with_index do |register, idx|
          # self.instance_eval do
            self.class.send(:define_method, "#{register[:name]}", proc{ self.get_value( "#{idx}".to_i ) })
            self.class.send(:define_method, "#{register[:name]}=", proc{ |value| self.set_value( "#{idx}".to_i, value ) })
          # end
        end
      end
      
      
      def initialize_registers
        require 'yaml'
        @registers = YAML::load_file(File.join(File.dirname(__FILE__), "registers.yml"))
       
        timestamp = Time.new
        @registers.each do |reg|
          reg.merge!({ :value => 0, :updated_at => timestamp })
        end
      end
    end
  end
end
