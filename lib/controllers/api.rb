require 'grape'
require_relative '../models/em'

module Jackalope
  class API < Grape::API
    version 'v1'
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    desc "Documents"
    get :documents, jbuilder: 'document.jbuilder' do
      doi = "10.1371/journal.pone.0050000"
      @document = Document.where(DOI: doi).first
    end
  end
end