class SecondPartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_make, only: %i[new create edit update]

  def index
    @second_parts = SecondPart.all
  end

  def new
    @second_part = @make.build_second_part
  end

  def edit
    @second_part = @make.second_part || @make.build_second_part
  end

  def update
    @second_part = @make.second_part || @make.build_second_part(second_part_params)
    @second_part.user = current_user

    if @second_part.update(second_part_params)
      redirect_to @make, notice: 'Second part was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @second_part = @make.build_second_part(second_part_params)
    @second_part.user = current_user

    if @second_part.save
      redirect_to @make, notice: 'Second part was successfully created.'
    else
      render :edit
    end
  end

  private

  def set_make
    @make = Make.find(params[:make_id])
  end

  def second_part_params
    params.require(:second_part).permit(:content)
  end
end
