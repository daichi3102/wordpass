class LikesController < ApplicationController
  def create
    make = Make.find(params[:make_id])
    current_user.like(make)
    redirect_to makes_path, notice: 'You unliked a make.'
  end

  def destroy
    make = current_user.likes.find(params[:id]).make
    current_user.unlike(make)
    redirect_to make_path, notice: 'You liked a make.'
  end
end
