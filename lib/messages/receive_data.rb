module HAIthermo
  class ReceiveData < Message
    def initialize(thermo_address, data)
      self.super(thermo_address, 1, 2, data)
    end
    
    def start_register(data)
      
    end
    
    def generage_register_data(data)
      
    end
  end
end
