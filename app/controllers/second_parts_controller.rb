# frozen_string_literal: true

class SecondPartsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_make, only: %i[new create]
  before_action :set_make_and_second_part, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]

  # first_partsが存在しないmakeのみを取得
  def index
    @second_parts = SecondPart.without_first_part.page(params[:page])
  end

  def new
    @second_part = @make.build_second_part
  end

  def create
    @second_part = @make.build_second_part(second_part_params)
    @second_part.user = current_user

    if @second_part.save
      # 通知作成メソッドの呼び出し
      @make.create_information_second_part!(current_user)
      redirect_to @make, notice: t('defaults.flash_message.created', item: SecondPart.model_name.human)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @second_part.update(second_part_params)
      redirect_to @make, notice: t('defaults.flash_message.updated', item: SecondPart.model_name.human)
    else
      render :edit
    end
  end

  private

  def set_make
    @make = Make.find(params[:make_id])
  end

  def set_make_and_second_part
    @make = Make.find(params[:make_id])
    @second_part = @make.second_part
  end

  def authorize_user!
    return if current_user == @make.first_part&.user || current_user == @make.second_part&.user

    redirect_to makes_path, alert: t('defaults.flash_message.not_authorized')
  end

  def second_part_params
    params.require(:second_part).permit(:content)
  end
end
