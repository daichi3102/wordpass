# frozen_string_literal: true

class InformationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @informations = Information.where('visited_id = ? OR visitor_id = ?', current_user.id, current_user.id)
                               .order(created_at: :desc)
                               .page(params[:page])
    # 未確認の通知が存在する場合のみ、確認済みに更新する
    @informations.where(checked: false).update_all(checked: true)
  end
end
