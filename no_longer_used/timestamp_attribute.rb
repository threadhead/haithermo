module HAIthermo
  module TimestampAttribute
    require 'time'
    
    def attr_timestamped(*args)
      # puts 'attr_timestamped: ' + self.to_s
      args.each{ |a|

        define_method(a) {
            instance_variable_get("@#{a}")
        }

        define_method("#{a}=") { |value|
          instance_variable_set("@#{a}", value)
          instance_variable_set("@#{a}_timestamp", Time.now)
        }

        define_method( a.to_s + '_timestamp') {
          instance_variable_get("@#{a}_timestamp")
        }
      }
    end
  end
end