# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-station}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yutaka HARA"]
  s.date = %q{2009-07-18}
  s.description = %q{Create, Distribute, and Install Ruby applications easily}
  s.email = %q{yutaka.hara/at/gmail.com}
  s.files = [
    "Rakefile",
     "VERSION",
     "config.rb",
     "controller/applications.rb",
     "controller/init.rb",
     "controller/main.rb",
     "layout/default.xhtml",
     "lib/ruby-station.rb",
     "model/application.rb",
     "model/init.rb",
     "public/css/ramaze_error.css",
     "public/dispatch.fcgi",
     "public/favicon.ico",
     "public/js/jquery.js",
     "public/ramaze.png",
     "public/spinner.gif",
     "ruby-station.gemspec",
     "spec/main.rb",
     "start.rb",
     "start.ru",
     "util/gem-manager.rb",
     "view/applications/do_install.xhtml",
     "view/applications/install.xhtml",
     "view/applications/uninstall.xhtml",
     "view/index.xhtml"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/yhara/ruby-station}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Create, Distribute, and Install Ruby applications easily}
  s.test_files = [
    "spec/main.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
