# -*- encoding: utf-8 -*-
# stub: jekyll-webp 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-webp".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sverrir Sigmundarson".freeze]
  s.date = "2023-04-14"
  s.description = "WebP Image Generator for Jekyll 3 Sites that automatically generate WebP images for all images on your static site and serves them when possible. Includes the v0.6.1 version of the WebP utilities for Windows, Linux and Mac OS X 10.9 (Mountain Lion)".freeze
  s.email = ["jekyll@sverrirs.com".freeze]
  s.executables = ["linux-x64-cwebp".freeze, "linux-x86-cwebp".freeze, "osx-cwebp".freeze, "win-x64-cwebp.exe".freeze, "win-x86-cwebp.exe".freeze]
  s.files = ["CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "LICENSE".freeze, "README.md".freeze, "Rakefile".freeze, "bin/linux-x64-cwebp".freeze, "bin/linux-x86-cwebp".freeze, "bin/osx-cwebp".freeze, "bin/win-x64-cwebp.exe".freeze, "bin/win-x86-cwebp.exe".freeze, "jekyll-webp.gemspec".freeze, "lib/jekyll-webp".freeze, "lib/jekyll-webp.rb".freeze, "lib/jekyll-webp/defaults.rb".freeze, "lib/jekyll-webp/version.rb".freeze, "lib/jekyll-webp/webpExec.rb".freeze, "lib/jekyll-webp/webpGenerator.rb".freeze, "spec/imgs".freeze, "spec/imgs/test_1.png".freeze, "spec/imgs/test_2.jpg".freeze, "spec/jekyll-webp".freeze, "spec/jekyll-webp/webpGenerator_spec.rb".freeze, "spec/spec_helper.rb".freeze]
  s.homepage = "https://github.com/sverrirs/jekyll-webp".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "WebP image generator for Jekyll 3 websites".freeze
  s.test_files = ["spec/imgs".freeze, "spec/imgs/test_1.png".freeze, "spec/imgs/test_2.jpg".freeze, "spec/jekyll-webp".freeze, "spec/jekyll-webp/webpGenerator_spec.rb".freeze, "spec/spec_helper.rb".freeze]

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<jekyll>.freeze, ["~> 4.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
  else
    s.add_dependency(%q<jekyll>.freeze, ["~> 4.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
