# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eisiges/di/core/version'

Gem::Specification.new do |spec|
	spec.name          = "eisiges-di-core"
	spec.version       = Eisiges::DI::Core::VERSION
	spec.authors       = ["Sam McCollum"]
	spec.email         = ["kg6zvp@gmail.com"]

	spec.summary       = %q{Dependency Injection Mixin for classes}
	#spec.description   = %q{TODO: Write a longer description or delete this line.}
	spec.homepage      = "http://gitlab.mccollum.enterprises/?"

	# Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
	# to allow pushing to a single host or delete this section to allow pushing to any host.
	if spec.respond_to?(:metadata)
		spec.metadata['allowed_push_host'] = 'http://gems.mccollum.enterprises'
	else
		raise "RubyGems 2.0 or newer is required to protect against " \
		      "public gem pushes."
	end
	
	#spec.files         = `git ls-files -z`.split("\x0").reject do |f|
	#	f.match(%r{^(test|spec|features)/})
	#end
	#puts "spec.files = #{spec.files}"
	
	spec.files         = [".gitignore", ".gitlab-ci.yml", ".travis.yml", "CODE_OF_CONDUCT.md", "Gemfile", "README.md", "Rakefile", "bin/console", "bin/setup", "eisiges-di-core.gemspec", "lib/eisiges/di/core.rb", "lib/eisiges/di/core/version.rb"]

	spec.bindir        = "exe"
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.13"
	spec.add_development_dependency "rake", "~> 10.0"
	spec.add_development_dependency "minitest", "~> 5.0"
	spec.add_development_dependency "pry"
end
