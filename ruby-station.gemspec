# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-station}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yutaka HARA"]
  s.date = %q{2009-10-02}
  s.default_executable = %q{bin/ruby-station}
  s.description = %q{Create, Distribute, and Install Ruby applications easily}
  s.email = %q{yutaka.hara/at/gmail.com}
  s.executables = ["bin/ruby-station"]
  s.extra_rdoc_files = [
    "ChangeLog"
  ]
  s.files = [
    ".gitignore",
     "ChangeLog",
     "Rakefile",
     "VERSION",
     "bin/ruby-station",
     "config.rb",
     "controller/applications.rb",
     "controller/init.rb",
     "controller/main.rb",
     "layout/default.xhtml",
     "model/application.rb",
     "model/init.rb",
     "public/css/ramaze_error.css",
     "public/dispatch.fcgi",
     "public/favicon.ico",
     "public/js/jquery.js",
     "public/ramaze.png",
     "public/spinner.gif",
     "ruby-station.gemspec",
     "runtime/Rakefile",
     "runtime/VERSION",
     "runtime/lib/ruby-station.rb",
     "runtime/lib/ruby-station/helper.rb",
     "runtime/lib/ruby-station/helper/rails.rb",
     "runtime/ruby-station-runtime-0.0.4.gem",
     "sample.config.yaml",
     "tests/README",
     "tests/Rakefile",
     "tests/data/conf_dir/config.yaml",
     "tests/features/install_file.feature",
     "tests/features/install_name.feature",
     "tests/features/list.feature",
     "tests/features/step_definitions/application_steps.rb",
     "tests/features/step_definitions/curelity_steps.rb",
     "tests/features/support/env.rb",
     "tests/features/uninstall.feature",
     "tests/features/upgrade.feature",
     "tests/spec/gem_manager.rb",
     "tests/test_helper.rb",
     "util/gem_manager.rb",
     "util/servant.rb",
     "view/applications/do_install.xhtml",
     "view/applications/foo.xhtml",
     "view/applications/install.xhtml",
     "view/applications/uninstall.xhtml",
     "view/index.xhtml",
     "view/notfound.xhtml"
  ]
  s.homepage = %q{http://github.com/yhara/ruby-station}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Create, Distribute, and Install Ruby applications easily}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ramaze>, ["= 2009.07"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_runtime_dependency(%q<do_sqlite3>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_development_dependency(%q<cucumber>, [">= 0.3.101"])
    else
      s.add_dependency(%q<ramaze>, ["= 2009.07"])
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<do_sqlite3>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_dependency(%q<cucumber>, [">= 0.3.101"])
    end
  else
    s.add_dependency(%q<ramaze>, ["= 2009.07"])
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<do_sqlite3>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.8"])
    s.add_dependency(%q<cucumber>, [">= 0.3.101"])
  end
end
