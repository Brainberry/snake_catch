# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{snake_catch}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Igor Galeta"]
  s.date = %q{2010-09-07}
  s.description = %q{Send exceptions to Snake server for store}
  s.email = %q{galeta.igor@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "lib/snake_catch.rb",
     "lib/snake_catch/issue.rb",
     "lib/snake_catch/middleware.rb",
     "lib/snake_catch/notifier.rb",
     "lib/snake_catch/railtie.rb",
     "lib/snake_catch/rescue.rb",
     "lib/snake_catch/version.rb"
  ]
  s.homepage = %q{http://github.com/Brainberry/snake_catch}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{snake_catch}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Rails plugin for catch exception and sent it to Snake API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<curb>, [">= 0"])
    else
      s.add_dependency(%q<curb>, [">= 0"])
    end
  else
    s.add_dependency(%q<curb>, [">= 0"])
  end
end

