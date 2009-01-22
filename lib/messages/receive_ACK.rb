module HAIthermo
  class ReceiveACK < Message
    def initialize(thermo_address)
      self.super(thermo_address, 1, 0, '')
      @host_or_reply = 1
      @message_type = 0
    end
  end
end
