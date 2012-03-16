require 'rspec'
require 'darksky'
require 'vcr'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :typhoeus
  c.allow_http_connections_when_no_cassette = false
end

RSpec.configure do |config|
end
