module HAIthermo
  class ReceiveACK < Message
    def initialize(thermo_address)
      self.super(thermo_address, 1, 1, '')
      @host_or_reply = 1
      @message_type = 1
    end
  end
end
