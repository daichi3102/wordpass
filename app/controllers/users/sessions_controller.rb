# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]

    protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    end
  end
end
