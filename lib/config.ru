require 'grape/jbuilder'
require_relative 'controllers/api'

use Rack::Config do |env|
  env['api.tilt.root'] = File.expand_path('../views/', __FILE__)
end

#puts Jackalope::API::routes

run Jackalope::API
