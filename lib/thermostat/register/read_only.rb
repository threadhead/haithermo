module HAIthermo
  module Thermostat
    module Register
      
      class ReadOnly < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        # def value=(value)
        #   raise RegisterError.new("can not set value of read only register (#{self.number})")
        # end
        
        # allows the setting of the initial value, then prevents further
        # def set_initial_value
        #   
        # end
        
        def read_only?
          true
        end
        
      end
    end
  end
end