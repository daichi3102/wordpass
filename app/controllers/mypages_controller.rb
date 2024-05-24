# app/controllers/mypages_controller.rb
class MypagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @like_makes = current_user.likes.includes(:make).order(created_at: :desc).map(&:make)
    @makes = current_user.makes.order(created_at: :desc)
    @fetch_ais = current_user.fetch_ais.order(created_at: :desc)
  end
end
