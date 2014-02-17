require 'cgi'
require_relative '../spec_helper'

describe Jackalope::API do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  describe Jackalope::API do
    describe 'GET /v1/documents'
    it 'exists' do
      get '/v1/documents'
      expect(last_response.status).to eq(200)
    end

    it 'allows pagination' do
      per_page = 31
      page = 4
      get "/v1/documents?per_page=#{per_page}&page=#{page}"
      expect(last_response.status).to eq(200)

      json_response = JSON.parse last_response.body
      expect(json_response.length).to eq(per_page)
    end

    it 'can find a document by doi' do
      doi = '10.1371/journal.pone.0050000'
      get "/v1/documents?doi=#{CGI::escape(doi)}"
      expect(last_response.status).to eq(200)

      json_response = JSON.parse last_response.body
      expect(json_response.length).to eq(1)
      expect(json_response[0]['document']['doi']).to eq(doi)
    end
  end
end