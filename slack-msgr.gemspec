
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/config/constants'

Gem::Specification.new do |spec|
  spec.name          = 'slack-msgr'
  spec.version       = SlackMsgr::VERSION
  spec.authors       = ['Ryan Workman']
  spec.email         = ['rdavid1099@gmail.com']

  spec.summary       = %q{A Ruby gem to send and receive messages through Slack}
  spec.description   = %q{A Ruby gem to send and receive messages through Slack}
  spec.homepage      = 'https://github.com/rdavid1099/slack-msgr'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/rdavid1099/slack-msgr'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~>0.15.4'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.71.0'
  spec.add_development_dependency 'reek', '~> 5.4.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'pry'
end
