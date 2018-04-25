lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'timedoctor'
  spec.version       = TimeDoctor::VERSION
  spec.authors       = ['Eugene Yak']
  spec.email         = ['geneayak@gmail.com']

  spec.summary       = 'Client for TimeDoctor API'
  spec.homepage      = 'https://github.com/EugeneYak/timedoctor'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.15.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'codecov', '~> 0.1.10'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.55.0'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
  spec.add_development_dependency 'webmock', '~> 3.3'
end
