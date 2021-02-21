require 'swagger_helper'

RSpec.describe 'api/v1/contacts', type: :request do

  path '/contacts' do

    get 'List all contacts' do
      tags 'Contact'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      parameter name: "filter[search_by_tag]", in: :query, type: :string, required: false
      response '200', :success do
        run_test!
      end
    end

    post 'Create contact'  do
      tags 'Contact'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          contact: {
            type: :object,
            properties: {
              email: { type: :string, example: 'test@example.com'},
              first_name: { type: :string, example: 'john'},
              last_name: { type: :string, example: 'doe'},
              tag_attributes: {
                type: :array,
                description: 'array of tags for contact (new or existing)',
                items: {
                  type: :object,
                  properties: {
                    name: { type: :string, example: 'win'}
                  }
                }
              }
            }
          }
        }
      }
      response '200', :success do
        let(:params) {{
            contact: {
              email: Faker::Internet.unique.email,
              first_name: Faker::Internet.first_name,
              last_name: Faker::Internet.last_name,
              tag_attributes: [{ name: 'not_interested'},{ name: 'wonBusiness'}]
            }
          }}
        run_test!
      end
    end
  end


  path '/contacts/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch('update contact') do
      tags 'Contact'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
end
