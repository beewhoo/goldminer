class Api::V1::ContactsController < Api::V1::BaseController

  def index
    @contacts = Contact
    .includes(:tags)
    .paginate(pagination_params)

    render(
      json: @contacts,
      each_serializer: Api::ContactSerializer,
      status: 200,
      meta: meta_attributes(@contacts)
    )
 end

  def create
  end

  def update
  end

  def destroy
  end


end
