module HAIthermo
  class PollForGroup1Data < Message
    def initialize(thermo_address)
      self.super(thermo_address, 0, 2, '')
      @host_or_reply = 0
      @message_type = 2
    end
  end
end
