class MakesController < ApplicationController
  before_action :authenticate_user!

  def index
    @makes = Make.all
  end

  def show
    @make = Make.find(params[:id])
  end

  def new
    @make = Make.new
    @make.build_first_part
    @make.build_second_part
  end

  def create
    @make = Make.new(make_params)
    @make.user = current_user

    if params[:make][:first_part_attributes][:content].present?
      @make.build_first_part(content: params[:make][:first_part_attributes][:content], user: current_user)
    end

    if params[:make][:second_part_attributes][:content].present?
      @make.build_second_part(content: params[:make][:second_part_attributes][:content], user: current_user)
    end

    if @make.save
      redirect_to @make, notice: 'Make was successfully created.'
    else
      render :new
    end
  end

  private

  def make_params
    params.require(:make).permit(
      first_part_attributes: %i[content user_id],
      second_part_attributes: %i[content user_id]
    )
  end
end
