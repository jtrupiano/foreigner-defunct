require 'rake'
require 'rake/packagetask'
require 'rake/gempackagetask'

require "./lib/foreigner/version"

PKG_NAME      = "foreigner"
PKG_BUILD     = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
PKG_VERSION   = Foreigner::Version::STRING + PKG_BUILD
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

GEM_SPEC = eval(File.read("#{File.dirname(__FILE__)}/#{PKG_NAME}.gemspec"))

Rake::GemPackageTask.new(GEM_SPEC) do |p|
  p.gem_spec = GEM_SPEC
  p.need_tar = true
  p.need_zip = true
end

desc "Clean up generated directories and files"
task :clean do
  rm_rf "pkg"
end
