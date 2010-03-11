require 'rubygems'
require 'rake'
require 'rake/gempackagetask'
 
$:.unshift File.join(File.dirname(__FILE__), '/lib')
require 'gallery'
 
PKG_NAME = 'gallery-remote'
PKG_VERSION = Gallery::VERSION
 
LIB_FILES = Dir.glob('lib/**/*')
RELEASE_FILES = [ 'Rakefile', 'README' ] + LIB_FILES
 
task :default => [ :package ]
 
spec = Gem::Specification.new do |spec|
  spec.name = PKG_NAME
  spec.version = PKG_VERSION
  spec.summary = 'A Ruby client for the Gallery2 photo gallery system'
  spec.description = 'gallery-remote is an implementation of the Gallery Remote protocol in Ruby.'
  spec.authors = 'Carl Leiby and Matt Walker'
  spec.email = 'matt.r.walker@gmail.com'
  spec.homepage = 'http://github.com/carlism/gallery-remote'
  spec.files = RELEASE_FILES
end
 
Rake::GemPackageTask.new(spec) do |package|
  package.need_tar = true
end
