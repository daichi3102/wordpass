# frozen_string_literal: true

class MypagesController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def profile
    @user = current_user
    render partial: 'mypages/profile'
  end

  def ai
    @fetch_ais = current_user.fetch_ais
    render partial: 'mypages/ai'
  end

  def makes
    @makes = current_user.makes
    render partial: 'mypages/makes'
  end

  def likes
    @like_makes = current_user.like_makes
    render partial: 'mypages/likes'
  end
end
