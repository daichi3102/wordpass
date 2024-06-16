class InformationsController < ApplicationController
  def index
    @informations = current_user.passive_informations.page(params[:page])
    # 未確認の通知に関しては、確認済みに更新する
    @informations.where(checked: false).each do |information|
      # 通知のcheckedカラムをtrueに更新
      information.update_attributes(checked: true)
    end
  end
end
