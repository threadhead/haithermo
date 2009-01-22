module HAIthermo
  class PollForGroup2Data < Message
    def initialize(thermo_address)
      self.super(thermo_address, 0, 3, '')
    end
  end
end
