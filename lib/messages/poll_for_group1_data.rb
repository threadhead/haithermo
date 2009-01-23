module HAIthermo
  class PollForGroup1Data < Message
    def initialize(thermo_address)
      message_type = 2
      super(thermo_address, 'host', message_type, '')
    end
  end
end
