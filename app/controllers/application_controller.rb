# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # rescue_from StandardError, with: :render500                # 二番目に動作
  # rescue_from ActiveRecord::RecordNotFound, with: :render404 # 一番目に動作
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :danger

  # def render500(error = nil)
  #   Rails.logger.error("❌#{error.message}") if error
  #   render template: 'errors/error500', layout: 'error', status: :internal_server_error
  # end
  #
  # def render404(error = nil)
  #   Rails.logger.error("❌#{error.message}") if error
  #   render template: 'errors/error404', layout: 'error', status: :not_found
  # end
  #
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end
end
