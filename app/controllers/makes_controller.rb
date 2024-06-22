# frozen_string_literal: true

class MakesController < ApplicationController
  # except: [:index]でindexアクションのみログインしていなくてもアクセスできる
  before_action :authenticate_user!, except: [:index]
  before_action :set_make, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[show edit update]

  def index
    @q = Make.ransack(params[:q])
    @makes = @q.result(distinct: true).includes(:first_part, :second_part,
                                                :likes).page(params[:page])
    @make = Make.new
    @make.build_first_part
    @make.build_second_part
  end

  def show
    @make = Make.find_by(id: params[:id])
    @user = @make.user
    @likes_count = Like.where(make_id: @make.id).count
  end

  def new
    @make = Make.new
    @make.build_first_part
    @make.build_second_part
  end

  def create
    @make = Make.new(make_params)
    @make.user = current_user

    @make.build_first_part(content: params[:make][:first_part_attributes][:content], user: current_user) if params[:make][:first_part_attributes][:content].present?

    @make.build_second_part(content: params[:make][:second_part_attributes][:content], user: current_user) if params[:make][:second_part_attributes][:content].present?

    if @make.save
      redirect_to @make, notice: t('defaults.flash_message.created', item: Make.model_name.human)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @make.update(make_params)
      redirect_to @make, notice: t('defaults.flash_message.updated', item: Make.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @make.destroy
    redirect_to makes_path, notice: t('defaults.flash_message.destroy', item: Make.model_name.human)
  end

  def likes
    @like_makes = current_user.like_makes.includes(:user).order(created_at: :desc)
  end

  private

  def set_make
    @make = Make.find(params[:id])
  end

  def authorize_user!
    return if current_user == @make.user || current_user == @make.first_part&.user || current_user == @make.second_part&.user

    redirect_to makes_path, alert: t('defaults.flash_message.not_authorized')
  end

  def make_params
    params.require(:make).permit(
      first_part_attributes: %i[id content],
      second_part_attributes: %i[id content]
    )
  end
end
