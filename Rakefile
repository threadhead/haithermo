require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "haithermo"
    gem.summary = "A ruby library that implements the HAI Omnistat Thermostat protocol"
    gem.description = "A ruby library that implements the HAI Omnistat Thermostat protocol"
    gem.email = "threadhead@gmail.com"
    gem.homepage = "http://github.com/threadhead/haithermo"
    gem.authors = ["Karl Smith"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
desc 'Run all unit and functional tests'
task :test do
  errors = %w(test:units test:functionals).collect do |task|
    begin
      Rake::Task[task].invoke
      nil
    rescue => e
      task
    end
  end.compact
  abort "Errors running #{errors.message}!" if errors.any?
end


namespace :test do
  Rake::TestTask.new(:units) do |test|
    test.libs << 'lib' << 'test'
    test.pattern = 'test/unit/**/test_*.rb'
    test.verbose = true
  end
  Rake::Task['test:units'].comment = "Run the unit tests in test/unit"
  
  Rake::TestTask.new(:functionals) do |test|
    test.libs << 'lib' << 'test'
    test.pattern = 'test/functional/**/test_*.rb'
    test.verbose = true
  end
  Rake::Task['test:functionals'].comment = "Run the functional tests in test/functional"
  
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "the-perfect-gem #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
