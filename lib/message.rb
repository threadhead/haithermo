Dir["#{File.dirname(__FILE__)}/message/*.rb"].each do |path|
  require_relative "message/#{File.basename(path)}"
end
