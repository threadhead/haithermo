module HAIthermo
  module Thermostat
    module Register
      
      class OmniTimeError < StandardError; end
      
      class OmniTime < Base
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        
        def time
          Time.local(2000, 1, 1, 0, 0, 0) + ( 15 * 60 * @value )
        end
        
        def time_s_24h
          self.time.strftime("%H:%M")
        end
        
        def time_s_12h
          self.time.strftime("%I:%M") + ( self.time.hour > 12 ? 'pm' : 'am')
        end
        
        def time=(datetime)
          begin
            if datetime.is_a?(String)
              dt_parse = DateTime.parse(dattime)
            else
              dt_parse = datetime
            end
            @value = (dt_parse.hour * 4) + (dt_parse.min / 15.0).round
          rescue
            raise OmniTimeError.new("'#{datetime}' could not be converted to valid time")
          end
        end
        
      end
    end
  end
end