class MypagesController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def profile
    @user = current_user
    render partial: 'mypages/profile'
  end

  def ai
    @fetch_ais = current_user.fetch_ais.order(created_at: :desc)
    render partial: 'mypages/ai'
  end

  def makes
    @makes = current_user.makes.order(created_at: :desc)
    render partial: 'mypages/makes'
  end

  def likes
    @like_makes = current_user.like_makes.order(created_at: :desc)
    render partial: 'mypages/likes'
  end
end
