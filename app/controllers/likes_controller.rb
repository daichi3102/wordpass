class LikesController < ApplicationController
  def create
    @make = Make.find(params[:make_id])
    current_user.like(@make)
  end

  def destroy
    @make = current_user.likes.find(params[:id]).make
    current_user.unlike(@make)
  end
end
