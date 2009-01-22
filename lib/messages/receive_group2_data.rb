module HAIthermo
  class ReceiveGroup2Data < Message
    def initialize(thermo_address, data)
      self.super(thermo_address, 1, 4, data)
      @host_or_reply = 1
      @message_type = 4
    end
  end
end
