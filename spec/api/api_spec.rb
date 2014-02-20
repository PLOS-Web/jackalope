require 'cgi'
require 'pp'
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
      doi = '10.1371/journal.pbio.1001788'
      get "/v1/documents?doi=#{CGI::escape(doi)}"
      expect(last_response.status).to eq(200)

      json_response = JSON.parse last_response.body
      expect(json_response.length).to eq(1)
      expect(json_response[0]['doi']).to eq(doi)
    end

    it 'provides a list of authors' do
      doi = '10.1371/journal.pbio.1001788'
      get "/v1/documents?doi=#{CGI::escape(doi)}"
      expect(last_response.status).to eq(200)

      json_response = JSON.parse last_response.body
      expect(json_response.length).to eq(1)
      expect(json_response[0]['authors'].count).to eq(3)
    end

    it 'can respond to a list of dois as a filter' do
      dois = []
      (1001000..1001020).each do |i|
        dois << CGI::escape("10.1371/journal.pbio." + i.to_s)
      end
      doi_query = dois.join '&doi[]=' #looks like &doi[]=x&doi[]=y...

      get "/v1/documents?doi[]=#{doi_query}"
      json_response = JSON.parse last_response.body
      expect(json_response.length).to eq(dois.length)
    end
  end
end