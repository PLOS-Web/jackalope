require 'bundler'
Bundler.require
require File.expand_path('../controllers/api.rb', __FILE__)

use Rack::Config do |env|
  env['api.tilt.root'] = File.expand_path('../views/', __FILE__)
end

run Jackalope::API
