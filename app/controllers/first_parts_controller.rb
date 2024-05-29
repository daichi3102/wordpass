class FirstPartsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_make, only: %i[new create]
  before_action :set_make_and_first_part, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]

  # second_partsが存在しないmakeのみを取得
  def index
    @first_parts = FirstPart.joins(:make)
                            .where(makes: { id: Make.left_outer_joins(:second_part)
                                                .where(second_parts: { id: nil })
                                                .select(:id) })
                            .order(created_at: :desc)
  end

  def new
    @first_part = @make.build_first_part
  end

  def edit
  end

  def update
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

  def set_make_and_first_part
    @make = Make.find(params[:make_id])
    @first_part = @make.first_part
  end

  def authorize_user!
    return if current_user == @make.first_part&.user || current_user == @make.second_part&.user

    redirect_to @make, alert: 'You are not authorized to perform this action.'
  end

  def first_part_params
    params.require(:first_part).permit(:content)
  end
end
