module HAIthermo
  module Thermostat
    module Register2
      
      class Reserved < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def value=(value)
          raise RegisterError.new("can not set value of reserved register (#{self.number})")
        end
        
        def value
          raise RegisterError.new("can not get value of reserved register (#{self.number})")
        end
        
        def to_hash
          {}
        end
        
      end
    end
  end
end