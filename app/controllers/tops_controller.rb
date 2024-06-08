# frozen_string_literal: true

class TopsController < ApplicationController
  def index
    # パーソナライズ機能を追加した際に必要になった
    @fetch_ai = FetchAi.new
    # もしくは
    # @fetch_ai = FetchAi.find(params[:id])
  end
end
