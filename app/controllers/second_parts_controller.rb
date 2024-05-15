class SecondPartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_make, only: %i[new create edit update]

  # first_partsが存在しないmakeのみを取得
  def index
    @second_parts = SecondPart.joins(:make)
                              .where(makes: { id: Make.left_outer_joins(:first_part)
                                                  .where(first_parts: { id: nil })
                                                  .select(:id) })
                              .order(created_at: :desc)
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
