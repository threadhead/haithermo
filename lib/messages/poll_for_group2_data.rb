module HAIthermo
  class PollForGroup2Data < Message
    def initialize(thermo_address)
      self.super(thermo_address, 0, 3, '')
      @host_or_reply = 0
      @message_type = 3
    end
  end
end
