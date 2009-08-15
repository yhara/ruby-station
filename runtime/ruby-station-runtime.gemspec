# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-station-runtime}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yutaka HARA"]
  s.date = %q{2009-08-14}
  s.email = %q{yutaka.hara/at/gmail.com}
  s.files = ["Rakefile", "lib/ruby-station.rb"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Runtime library for RubyStation}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
