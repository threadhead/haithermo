class Fixnum
  
    def bit_set(bit_to_set)
      bit_range_verification(self)
      self | ( 2 ** bit_to_set )
    end
    
    def bit_clear(bit_to_clear)
      bit_range_verification(self)
      self & ((2 ** bit_to_clear) ^ 0b11111111)
    end

    def bit_get(bit_to_get)
      bit_range_verification(self)
      self[bit_to_get]
    end
    
    def bit_range_verification(byte)
      raise ArgumentError.new("can only set bits of integers 0..255") if byte < 0 || byte > 255  
    end
    
end