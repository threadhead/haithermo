module HAIthermo
  class ReceiveGroup2Data < Message
    def initialize(thermo_address, data)
      self.super(thermo_address, 1, 4, data)
    end
  end
end
