# -*- encoding: utf-8 -*-
# stub: mongoid_auto_increment 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "mongoid_auto_increment".freeze
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Peter Savichev (proton)".freeze]
  s.date = "2016-12-05"
  s.description = "Add SQL like auto-incrementing fields to your Mongoid documents.".freeze
  s.email = "psavichev@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/proton/mongoid_auto_increment".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Auto-incrementing fields for Mongoid documents".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>.freeze, [">= 2.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.1.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rack>.freeze, ["~> 1.6.4"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.0.0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0.4.0"])
      s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0.8.0"])
    else
      s.add_dependency(%q<mongoid>.freeze, [">= 2.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.1.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rack>.freeze, ["~> 1.6.4"])
      s.add_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 2.0.0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0.4.0"])
      s.add_dependency(%q<database_cleaner>.freeze, [">= 0.8.0"])
    end
  else
    s.add_dependency(%q<mongoid>.freeze, [">= 2.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.1.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.6.4"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.0.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0.4.0"])
    s.add_dependency(%q<database_cleaner>.freeze, [">= 0.8.0"])
  end
end
