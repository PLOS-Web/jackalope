require_relative '../spec_helper'

describe Jackalope::API do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  describe Jackalope::API do
    describe 'GET /v1/documents'
    it 'successfully responds' do
      get '/v1/documents'
      expect(last_response.status).to eq(200)
    end
  end


end