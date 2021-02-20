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
   @contact = Contact.new(contact_params)

   if @contact.save
     render(
       json: @contact,
       serializer: Api::ContactSerializer,
       status: 201,
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
         status: 200,
       )
     rescue => e
       render_error :unprocessable_entity, 'ValidationError', @contact.errors.messages
     end
   else
     render_not_found(@contact)
   end
 end

 def destroy
 end

 private

 def contact_params
   params.require(:contact).permit(
     :first_name,
     :last_name,
     :email
   )
 end

 def contact_id
    params.require(:id)
  end



end
