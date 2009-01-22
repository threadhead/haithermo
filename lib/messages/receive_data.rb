module HAIthermo
  class ReceiveData < Message
    def initialize(thermo_address, data)
      self.super(thermo_address, 1, 2, data)
      @host_or_reply = 1
      @message_type = 2
    end
    
    def start_register(data)
      
    end
    
    def generage_register_data(data)
      
    end
  end
end
