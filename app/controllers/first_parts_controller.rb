class FirstPartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_make, only: %i[new create edit update]

  def index
    @first_parts = FirstPart.all
  end

  def new
    @first_part = @make.build_first_part
  end

  def edit
    @first_part = @make.first_part || @make.build_first_part
  end

  def update
    @first_part = @make.first_part || @make.build_first_part(first_part_params)
    @first_part.user = current_user

    if @first_part.update(first_part_params)
      redirect_to @make, notice: 'First part was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @first_part = @make.build_first_part(first_part_params)
    @first_part.user = current_user

    if @first_part.save
      redirect_to @make, notice: 'First part was successfully created.'
    else
      render :edit
    end
  end

  private

  def set_make
    @make = Make.find(params[:make_id])
  end

  def first_part_params
    params.require(:first_part).permit(:content)
  end
end
