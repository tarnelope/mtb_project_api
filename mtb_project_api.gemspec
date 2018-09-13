
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mtb_project_api/version"

Gem::Specification.new do |spec|
  spec.name          = "mtb_project_api"
  spec.version       = MtbProjectApi::VERSION
  spec.authors       = ["Teresa Tarn"]
  spec.email         = ["teresa.tarn@kapost.com"]
  spec.license       = "MIT"
  spec.summary       = "Easily access MTB Project's provided endpoints."
  spec.description   = "A wrapper gem for the public MTB Project API"
  spec.homepage      = "https://www.github.com/tarnelope/mtb_project_api"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.15"
  spec.add_dependency "oj", "~> 3.6"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.4"
  spec.add_development_dependency "byebug", "~> 10.0"
end
