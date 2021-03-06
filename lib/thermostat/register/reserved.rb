module HAIthermo
  module Thermostat
    module Register
      
      class Reserved < ReadOnly
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def value
          raise RegisterError.new("can not get value of reserved register (#{self.number})")
        end
        
        def to_hash
          {}
        end
        
        def reserved?
          true
        end
        
        
      end
    end
  end
end