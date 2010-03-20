module HAIthermo
  module Thermostat
    module Registers
      
      class RegisterError < StandardError; end
      
            
      def self.extended(base)
        base.instance_variable_set(:@registers, Array.new)
      end
      
      def register_initialize(address)
        create_registers
        create_accessors
        self.register_named(:address).value = address
      end
      
      # def [](name)
      #   self.register_named( name.to_s )
      # end
      
      
      def register_named(name)
        idx = @registers.index{ |register| register.name == name.to_s }
        raise RegisterError.new("requested register (#{name}) does not exist") unless idx
        @registers[idx]
      end
    

      def register_number(number)
        idx = @registers.index{ |register| register.number == number }
        raise RegisterError.new("requested register (#{name}) does not exist") unless idx
        @registers[idx]
      end


    
      def set_value_range(start_register, values)
        start_register -= 1
        values.each do |value|
          self.register_number( start_register += 1 ).value = value
        end
      end
    
      def set_value_range_string(string)
        string_bytes = string.bytes.to_a
        self.set_value_range( string_bytes[0], string_bytes[1, 100])
      end
    
        
        
    
      def get_value_range(start_register, quantity)
        start_register -= 1
        arr = []
        quantity.times do
          arr << self.register_number( start_register += 1 ).value
        end
        arr
      end
    
      def get_value_range_string(start_register, quantity)
        # str = start_register.chr
        str = ""
        self.get_value_range(start_register, quantity).each{ |value| str << value.chr }
        str
      end
    


      def register_names
        @registers.map { |register| register.name }
      end
    
      def register_values_hash
        register_values = { :updated_at  => Time.now }
        @registers.each do |register|
          register_values.merge!( { register.name.to_sym => register.value } )
        end
        return register_values    
      end
  
      
    
      def dump
        puts "--- ALL REGISTER VALUES ---"
        @registers.map { |register| puts "name: #{register.name}, value: #{register.value}" }
      end

      # shamelessly copied and adapted from ActiveSupport::Inflector
      def camelize(lower_case_and_underscored_word)
         lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      end


      def constantize(lower_case_and_underscored_word)
        name = camelize( lower_case_and_underscored_word )
        HAIthermo::Thermostat::Register.const_defined?(name) ? HAIthermo::Thermostat::Register.const_get(name) : false
      end
  
  
      private
      def create_accessors
        @registers.each do |register|
          # self.instance_eval do
            self.class.send(:define_method, "#{register.name}", proc{ self.register_named("#{register.name}") })
            # self.class.send(:define_method, "#{register.name}", proc{ self.register_named("#{register.name}").value })
            # self.class.send(:define_method, "#{register.name}=", proc{ |value| self.register_named("#{register.name}").value = value })
          # end
        end
      end
    
    
      def create_registers
        require 'yaml'
        registers = YAML::load_file(File.join(File.dirname(__FILE__), "registers.yml"))
        
        registers.each do |register|
          klass = register[:type] ? constantize(register[:type]) : false
          
          if klass
            @registers << klass.new(register[:number], register[:name], register[:limits])
          else
            @registers << HAIthermo::Thermostat::Register::Base.new(register[:number], register[:name], register[:limits])
          end
        end
      end
      
     
            
    end
  end
end
