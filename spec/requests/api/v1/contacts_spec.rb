require 'swagger_helper'

RSpec.describe 'api/v1/contacts', type: :request do
  let(:contacts) { create_list(:contact, 10) }

  path '/contacts' do

    get 'List all contacts' do
      tags 'Contact'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      parameter name: "filter[search_by_tag]", in: :query, type: :string, required: false

      response 200, :success do
        schema type: :object,
          properties:{
            contacts: {
              type: :array,
              description: 'An arrray of contacts',
              items: {
                type: :object,
                properties: {
                  id: { type: :integer, example: '1'},
                  full_name: { type: :string, example: 'John Doe'},
                  email: { type: :string, example: 'exmaple@example.com'},
                  tags:{
                    type: :array,
                    description: 'Contact tags',
                    items: {
                      type: :object,
                      properties: {
                        id: { type: :integer, example: '1'},
                        name: { type: :string, example: 'lead'},
                        camel_case_name: { type: :string, example: 'HighValued'}
                      }
                    }
                  }
                }
              }
            }
          }
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
              tags_attributes: {
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
      response 201, :success do
        let(:params) {{
            contact: {
              email: Faker::Internet.unique.email,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              tags_attributes: [{ name: 'not_interested'},{ name: 'wonBusiness'}]
            }
          }}
        run_test!
      end

      response 422, :unprocessable_entity do
        let(:params) {{
            contact: {
              email: 'invalidemail',
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              tags_attributes: [{ name: 'not_interested'},{ name: 'wonBusiness'}]
            }
          }}
        run_test!
      end
    end
  end

  path '/contacts/{id}' do

    put 'Update contact' do
      tags 'Contact'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :integer, description: 'contact id'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          contact: {
            type: :object,
            properties: {
              email: { type: :string, example: 'test@example.com'},
              first_name: { type: :string, example: 'john'},
              last_name: { type: :string, example: 'doe'},
              tags_attributes: {
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
      response 200, :success do
        let(:id) {create(:contact).id}
        let(:params) {{
            contact: {
              email: Faker::Internet.unique.email,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              tags_attributes: [{ name: 'not_interested'},{ name: 'wonBusiness'}]
            }
          }}
        run_test!
      end

      response 422, :success do
        let(:exsiting_contact) { create(:contact)}
        let(:id) {create(:contact).id}
        let(:params) {{
            contact: {
              email: exsiting_contact.email,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              tags_attributes: [{ name: 'not_interested'},{ name: 'wonBusiness'}]
            }
          }}
        run_test!
      end

      response 404, :not_found do
        let(:id) {'invalid_id'}
        let(:params) {{
            contact: {
              email: Faker::Internet.unique.email,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              tags_attributes: [{ name: 'not_interested'},{ name: 'wonBusiness'}]
            }
          }}
        run_test!
      end
    end

    delete 'Delete contact' do
      tags 'Contact'
      parameter name: 'id', in: :path, type: :integer, description: 'contact id'
      produces 'application/json'

      response 200, :success do
        let(:id) {create(:contact).id}
        run_test!
      end

      response 404, :not_found do
        let(:id) {'invalid_id'}
        run_test!
      end
    end
  end
end
