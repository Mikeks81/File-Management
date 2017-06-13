# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "file_management/version"

Gem::Specification.new do |spec|
  spec.name          = "file_management"
  spec.version       = FileManagement::VERSION
  spec.authors       = ["Michael"]
  spec.email         = ["mikeks81@gmail.com"]

  spec.summary       = %q{File Management library for specific paths}
  spec.description   = %q{Simple file management program to allow CRUD like functions to a single directory. }
  spec.homepage      = "https://github.com/Mikeks81/File-Management"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "filesize", "~> 0.1.1"
end
