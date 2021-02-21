class Api::V1::BaseController < ApplicationController
  around_action :rescue_from_fk_contraint, only: [:destroy]

  # pagination
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

  # error handling
  def render_error(status, type, error)
    _body = { type: type }
    _key = error.is_a?(String) ? :message : :error_messages
    _body[_key] = error
    render(json: _body.to_json, status: status)
  end

  def render_not_found(_e)
    render_error :not_found, 'NotFound', 'Record not found'
  end

  def rescue_from_fk_contraint
    yield
  rescue ActiveRecord::InvalidForeignKey
    render_error :conflict, 'ForeignKeyConstraint', 'Cannot delete record'
  end
end
