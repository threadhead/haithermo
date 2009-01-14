require 'rubygems'
require 'rake'

# ----- Default: Testing ------

task :default => :test

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  test_files = FileList['test/test_*.rb']
  t.test_files = test_files
  t.verbose = true
end
# Rake::Task[:test].send(:add_comment, <<END)
# To run with an alternate version of Rails, make test/rails a symlink to that version.
# END

# ----- Packaging -----

# require 'rake/gempackagetask'
# load    'haml.gemspec'
# 
# Rake::GemPackageTask.new(HAML_GEMSPEC) do |pkg|
#   if Rake.application.top_level_tasks.include?('release')
#     pkg.need_tar_gz  = true
#     pkg.need_tar_bz2 = true
#     pkg.need_zip     = true
#   end
# end

# ----- Documentation -----

# begin
#   require 'hanna/rdoctask'
# rescue LoadError
#   require 'rake/rdoctask'
# end
# 
# Rake::RDocTask.new do |rdoc|
#   rdoc.title    = 'Haml/Sass'
#   rdoc.options << '--line-numbers' << '--inline-source'
#   rdoc.rdoc_files.include(*FileList.new('*') do |list|
#                             list.exclude(/(^|[^.a-z])[a-z]+/)
#                             list.exclude('TODO')
#                           end.to_a)
#   rdoc.rdoc_files.include('lib/**/*.rb')
#   rdoc.rdoc_files.exclude('TODO')
#   rdoc.rdoc_files.exclude('lib/haml/buffer.rb')
#   rdoc.rdoc_files.exclude('lib/sass/tree/*')
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.main = 'README.rdoc'
# end