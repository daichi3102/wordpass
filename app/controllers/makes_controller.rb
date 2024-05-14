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

    Rails.logger.debug "Make: #{@make.inspect}"
    Rails.logger.debug "First Part Params: #{params[:make][:first_part_attributes].inspect}"
    Rails.logger.debug "Second Part Params: #{params[:make][:second_part_attributes].inspect}"

    if params[:make][:first_part_attributes][:content].present?
      @make.build_first_part(content: params[:make][:first_part_attributes][:content], user: current_user)
      Rails.logger.debug "FirstPart: #{@make.first_part.inspect}"
    end

    if params[:make][:second_part_attributes][:content].present?
      @make.build_second_part(content: params[:make][:second_part_attributes][:content], user: current_user)
      Rails.logger.debug "SecondPart: #{@make.second_part.inspect}"
    end

    if @make.save
      Rails.logger.debug 'Make saved successfully'
      redirect_to @make, notice: 'Make was successfully created.'
    else
      Rails.logger.debug "Make save failed: #{@make.errors.full_messages}"
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
