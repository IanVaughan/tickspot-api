require 'rspec'
require 'rspec/autorun'
require 'fakeweb'

FakeWeb.allow_net_connect = false

RSpec.configure do |c|
  c.mock_with :rspec

  def fixture filename
    YAML.load_file File.join(File.dirname(__FILE__), 'fixtures', filename + '.yml')
  end
end
