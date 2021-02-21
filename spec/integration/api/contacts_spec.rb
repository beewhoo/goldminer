#spec/integration/user_spec.rb
require 'swagger_helper'

describe 'Contact', type: :request, swagger_doc: "v1/swagger.yaml" do

  path '/contacts' do
    let(:contacts) { create_list(:contact, 10) }

    get 'List all contacts' do
      tags 'Contact'
      consumes 'application./json'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      parameter name: "filter[search_by_tag]", in: :query, type: :string, required: false

      response '200', :success do
        run_test!
      end
    end
  end





end
