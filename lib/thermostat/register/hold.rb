module HAIthermo
  module Thermostat
    module Register
      
      class Hold < Base        
        def initialize(number, name, limits)
          super(number, name, limits)
        end
        
        def status
          case @value
          when 0
            'off'
          when 255
            'on'
          end
        end
        
        def status=(status)
          case status.to_s
          when 'on'
            @value = 255
          when 'off'
            @value = 0
          end
        end
        
        
        def off
          @value = 0
        end
        
        def on
          @value = 255
        end
        
        def off?
          @value == 0
        end
        
        def on?
          @value == 255
        end
        
      end
    end
  end
end