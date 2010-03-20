Dir["#{File.dirname(__FILE__)}/message/*.rb"].each do |path|
  require "lib/message/#{File.basename(path)}"
end
