require 'pp'
require 'grape'
require_relative '../models/em'

module Jackalope
  class API < Grape::API
    version 'v1'
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    resource :journals do


      route_param :journal_slug do

        params do
          optional :doi, type: Array
          optional :per_page, type: Integer, default: 50
          optional :page, type: Integer, default: 0
        end

        get 'documents', jbuilder: 'document.jbuilder' do
          docs_rel = Document
          if params[:doi]
            docs_rel = docs_rel.where(doi: params['doi'])
          end
          @documents = docs_rel.order(:actual_online_pub_date).paginated(per_page: params['per_page'], page: params['page'])
        end
      end
    end
  end
end

#puts Jackalope::API::routes