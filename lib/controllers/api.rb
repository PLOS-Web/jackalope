require 'pp'
require 'grape'
require_relative '../models/em'

module Jackalope
  class API < Grape::API
    version 'v1'
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    resource :documents do
      desc "Documents"

      params do
        optional :doi, type: Array
        optional :per_page, type: Integer, default: 50
        optional :page, type: Integer, default: 0

      end

      get '', jbuilder: 'document.jbuilder' do
        docs_rel = Document.where('DOI IS NOT NULL').where('ACTUAL_ONLINE_PUB_DATE IS NOT NULL')
        if params[:doi]
          docs_rel = docs_rel.where(doi: params['doi'])
        end
        @documents = docs_rel.limit(params['per_page']).offset(params['page']*(params['per_page'])).order(:actual_online_pub_date)
      end

    end
  end
end

#puts Jackalope::API::routes