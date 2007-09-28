# 
# Rakefile.rb
# 
# Created on Sep 14, 2007, 11:17:42 PM
# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :test do 
  require 'rake/runtest'
  Rake.run_tests '../**/test*.rb'
end
