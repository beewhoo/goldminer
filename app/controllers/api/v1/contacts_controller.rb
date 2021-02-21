class Api::V1::ContactsController < Api::V1::BaseController
  def index
    @contacts = Contact
                .filter(filter_params)
                .includes(:tags)
                .paginate(pagination_params)

    render(
      json: @contacts,
      each_serializer: Api::ContactSerializer,
      status: :ok,
      meta: meta_attributes(@contacts)
    )
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render(
        json: @contact,
        serializer: Api::ContactSerializer,
        status: :created
      )
    else
      render_error :unprocessable_entity, 'ValidationError', @contact.errors.messages
    end
  end

  def update
    if @contact = Contact.find_by(id: contact_id)
      begin
        @contact.update!(contact_params)
        render(
          json: @contact,
          serializer: Api::ContactSerializer,
          status: :ok
        )
      rescue StandardError => e
        render_error :unprocessable_entity, 'ValidationError', @contact.errors.messages
      end
    else
      render_error :not_found, 'NotFound', 'Record not found'
    end
  end

  def destroy
    if @contact = Contact.find_by(id: contact_id)

      @contact.destroy
      render json: {}, status: :ok
    else
      render_not_found(@contact)
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :first_name,
      :last_name,
      :email,
      tags_attributes: [:name]
    )
  end

  def contact_id
    params.require(:id)
  end

  def filter_params
    _params = params.dig(:filter)&.permit(
      :search_by_tag,
      search_by_tag: []
    ) || {}
  end
end
