# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :google_oauth2

    def google_oauth2
      callback_for(:google)
    end

    def callback_for(provider)
      @omniauth = request.env['omniauth.auth']
      info = User.find_oauth(@omniauth)
      @user = info[:user]
      if @user.persisted? # persisted?は保存が完了しているかを評価するメソッド
        sign_in_and_redirect @user, event: :authentication
        # is_navigational_formatはフラッシュメッセージを発行する必要があるかどうかを確認する
        # capitalizeは文字列の先頭を大文字に、それ以外は小文字に変更して返すメソッド
        set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
      else
        @sns = info[:sns]
        render template: 'devise/registrations/new'
      end
    end

    def failure
      redirect_to root_path and return
    end
  end
end
