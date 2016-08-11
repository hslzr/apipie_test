class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from Apipie::ParamError do |e|
    render json: { message: e.message }, status: 422
  end
end
