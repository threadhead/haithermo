module HAIthermo
  class PollForGroup1Data < Message
    def initialize(thermo_address)
      self.super(thermo_address, 0, 2, '')
    end
  end
end
