# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/foreigner.rb'
require "./lib/foreigner/version"

PKG_NAME      = "foreigner"
PKG_BUILD     = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
version = Foreigner::Version::STRING.dup
if ENV['SNAPSHOT'].to_i == 1
  version << "." << Time.now.utc.strftime("%Y%m%d%H%M%S")
end
PKG_VERSION   = version
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

Hoe.new(PKG_NAME, PKG_VERSION) do |p|
  p.rubyforge_name = 'johntrupiano' # if different than lowercase project name
  p.developer('John Trupiano', 'jtrupiano@gmail.com')
  p.name = PKG_NAME
  p.version = PKG_VERSION
  p.author = "John Trupiano"
  p.email = "jtrupiano@gmail.com"
  p.description = %q(This ruby executable (foreigner) will inspect a rails project's models and verify that their associations have a one-to-one correlation with the foreign key constraints set up in the MySQL database. )
  p.summary = p.description # More details later??
  p.remote_rdoc_dir = PKG_NAME # Release to /PKG_NAME
  #  p.changes = p.paragraphs_of('CHANGELOG', 0..1).join("\n\n")
  p.need_zip = true
  p.need_tar = false
end

# vim: syntax=Ruby
