# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Firebase::Auth::Authenticable
  before_action :authenticate_user

  class AuthenticationError < StandardError; end
  rescue_from AuthenticationError, with: :not_authenticated

  def render_error(message = '予期せぬエラーが発生しました', status = 400)
    render json: { error_message: message }, status: status
  end
end
