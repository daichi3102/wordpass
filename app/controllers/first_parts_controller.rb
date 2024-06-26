# frozen_string_literal: true

class FirstPartsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_make, only: %i[new create]
  before_action :set_make_and_first_part, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]

  # second_partsが存在しないmakeのみを取得
  def index
    @first_parts = FirstPart.without_second_part.page(params[:page])
  end

  def new
    @first_part = @make.build_first_part
  end

  def create
    @first_part = @make.build_first_part(first_part_params)
    @first_part.user = current_user

    if @first_part.save
      # 通知作成メソッドの呼び出し
      @make.create_information_first_part!(current_user)
      redirect_to @make, notice: t('defaults.flash_message.created', item: FirstPart.model_name.human)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @first_part.update(first_part_params)
      redirect_to @make, notice: t('defaults.flash_message.updated', item: FirstPart.model_name.human)
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

    redirect_to makes_path, alert: t('defaults.flash_message.not_authorized')
  end

  def first_part_params
    params.require(:first_part).permit(:content)
  end
end
