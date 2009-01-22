module HAIthermo
  class ReceiveGroup1Data < Message
    def initialize(thermo_address, data)
      self.super(thermo_address, 1, 3, data)
      @host_or_reply = 1
      @message_type = 3
    end
    
    # cool setpoint, heat setpoint, mode, fan, hold, current temperature
    
    def cool_setpoint
      
    end
    
    def heat_setpoint
      
    end
    
    def mode
      
    end
    
    def fan
      
    end
    
    def hold
      
    end
    
    def current_temperature
      
    end
  end
end
