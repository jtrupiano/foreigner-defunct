Gem::Specification.new do |s|
  s.name = "rails-association-verifier"
  s.version = PKG_VERSION
  s.platform = Gem::Platform::RUBY
  s.author = "John Trupiano"
  s.email = "jtrupiano@gmail.com"
  s.description = %q(This ruby executable (verify.rb) will inspect a rails project's models
    and verify that their associations have a one-to-one correlation with
    the foreign key constraints set up in the MySQL database. )
  s.summary = s.description # More details later??
  s.has_rdoc = false
  s.require_paths = ["lib"]
  
  s.files = Dir.glob("{lib}/**/*") + Dir['bin/*'] + %w(README)
  s.executables = ['verify']

end
