module HAIthermo
  class ReceiveACK < Message
    def initialize(thermo_address)
      self.super(thermo_address, 1, 1, '')
    end
  end
end
