# app/controllers/mypages_controller.rb
class MypagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @likes = current_user.likes
    @makes = current_user.makes
    @fetch_ais = current_user.fetch_ais
  end
end
