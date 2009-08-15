# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

require 'rcov/rcovtask'
require 'rcov/version'

namespace :rcov do
  
  desc "Run rcov for test/units, test/functionals"
  Rcov::RcovTask.new(:tests) do |t|
    t.test_files = FileList['test/unit/*_test.rb', 'test/functional/*_test.rb']
    t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/test\/}
    t.verbose = true
  end
  
end