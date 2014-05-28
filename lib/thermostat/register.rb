# require_relative 'register/base'
# require_relative 'register/read_only'


Dir["#{File.dirname(__FILE__)}/register/*.rb"].each do |path|
  # puts "path: #{File.basename path}"
  require "#{File.dirname(__FILE__)}/register/#{File.basename(path)}"
end
