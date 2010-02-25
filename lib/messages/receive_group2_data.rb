module HAIthermo
  class ReceiveGroup2Data < Message::Base
    def initialize(thermo_address, data)
      message_type = 4
      super(thermo_address, 'reply', message_type, data)
    end
  end
end
