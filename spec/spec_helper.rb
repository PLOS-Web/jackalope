require 'rubygems'
require 'bundler/setup'
require 'rack/test'

require_relative '../app/controllers/api'

OUTER_APP = Rack::Builder.parse_file(File.expand_path('../../app/config.ru', __FILE__)).first

RSpec.configure do |config|
  #config.include RSpec::Rails::RequestExampleGroup, type: :request, example_group: {
  #    file_path: /spec\/api/
  #}
end