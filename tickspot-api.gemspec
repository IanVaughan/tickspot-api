lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "tickspot_api"
  s.version     = '0.0.5'
  s.date        = Date.today.to_s

  s.platform    = Gem::Platform::RUBY

  s.authors     = "Ian Vaughan"
  s.email       = "github@ianvaughan.co.uk"
  s.homepage    = "http://github.com/ianvaughan/tickspot-api"

  s.summary     = "Ruby wrapper for the Tickspot API"
  s.description = "This allows your application easy access to the Tickspot API"

  s.add_development_dependency "rspec"

  s.require_path = 'lib'

  s.files            = Dir['lib/**/*']
  s.test_files       = Dir['spec/**/*']
end
