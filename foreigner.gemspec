Gem::Specification.new do |s|
  s.name = %q{foreigner}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Trupiano"]
  s.date = %q{2008-09-12}
  s.default_executable = %q{foreigner}
  s.description = %q{This ruby executable (foreigner) will inspect a rails project's models and verify that their associations have a one-to-one correlation with the foreign key constraints set up in the MySQL database.}
  s.email = %q{jtrupiano@gmail.com}
  s.executables = ["foreigner"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/foreigner", "foreigner.gemspec", "lib/foreigner.rb", "lib/foreigner/foreign_key.rb", "lib/foreigner/foreign_keys.rb", "lib/foreigner/reporter.rb", "lib/foreigner/verifier.rb", "lib/foreigner/version.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jtrupiano/foreigner/tree/master}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{johntrupiano}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{This ruby executable (foreigner) will inspect a rails project's models and verify that their associations have a one-to-one correlation with the foreign key constraints set up in the MySQL database.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
