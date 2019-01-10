
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "giff/version"

Gem::Specification.new do |spec|
  spec.name          = "giff"
  spec.version       = Giff::VERSION
  spec.authors       = ["John Hawthorn"]
  spec.email         = ["john@hawthorn.email"]

  spec.summary       = %q{Gem fIFF tool}
  spec.description   = %q{Show the changes between two .gem files}
  spec.homepage      = "https://github.com/jhawthorn/giff"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "minitar"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake", "~> 10.0"
end
