class Api::V1::BaseController < ApplicationController

  def meta_attributes(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }.merge(extra_meta)
  end

  def pagination_params
    _params = params.permit(:page, :per_page)
    _params[:page] ||= 1
    _params[:per_page] ||= 10
    _params.to_h
  end

  def render_error(status, type, error)
    _body = { type: type }
    _key = error.is_a?(String) ? :message : :error_messages
    _body[_key] = error

    render( json: _body.to_json, status: status )
  end



end
