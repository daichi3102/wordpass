# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @make = Make.find(params[:make_id])
    current_user.like(@make)
    # 通知作成メソッドの呼び出し
    @make.create_information_like!(current_user)
  end

  def destroy
    @make = current_user.likes.find(params[:id]).make
    current_user.unlike(@make)
  end
end
