module HAIthermo
  class ReceiveData < Message::Base
    def initialize(thermo_address, data)
      message_type = 2
      super(thermo_address, 'reply', message_type, data)
    end
    
    def start_register
      @data.getbyte(0)
    end
    
    def register_count
      @data.length - 1
    end
    
    def get_register_value(register_number)
      @data.getbyte( register_number - start_register + 1 )
    end
    
    # def generate_register_data
    #   @register_hash = []
    #   
    # end
  end
end
