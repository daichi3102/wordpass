# frozen_string_literal: true

class FetchAisController < ApplicationController
  before_action :authenticate_user!, only: %i[index edit update destroy]
  before_action :set_fetch_ai, only: %i[show edit update destroy]

  def index
    @fetch_ais = FetchAi.order(created_at: :desc).page(params[:page])
    @fetch_ai = FetchAi.new
  end

  def show; end

  def new
    @fetch_ai = if user_signed_in? && session[:last_fetch_ai_params].present?
                  FetchAi.new(session[:last_fetch_ai_params])
                else
                  FetchAi.new
                end
  end

  def create
    @fetch_ai = FetchAi.new(fetch_ai_params)
    @fetch_ai.user = current_user if user_signed_in?

    fetch_ai_data = params.fetch(:fetch_ai, {})
    prompt_type = fetch_ai_data[:prompt_type]
    prompt = case prompt_type
             when 'personalized'
               if user_signed_in?
                 mood = params[:fetch_ai][:mood]
                 schedule = params[:fetch_ai][:schedule]
                 how = params[:fetch_ai][:how]
                 popularity = params[:fetch_ai][:popularity]
                 quote_type = params[:fetch_ai][:quote_type]
                 <<~PROMPT
                   今は#{mood}な気分で、今日は#{schedule}をして過ごす予定です。
                   #{how}を、#{popularity}、#{quote_type}から1つ引用してください。
                   偉人や有名人の場合は、名前を記載してください。
                   書籍、映画、漫画、アニメの場合には引用作品名と、作者か登場人物名を記載してください。
                   対話型の返答は省き、引用情報のみの日本語、名言を<quote></quote>で括り、その他の情報を<info></info>で括ってください。
                 PROMPT
               end
             else
               <<~PROMPT
                 名言や格言と言われるものを、映画、書籍、漫画、アニメ等から１つ引用してください。
                 引用作品名、作者、登場人物名を記載してください。
                 対話型の返答は省き、引用情報のみの日本語、名言を<quote></quote>で括り、その他の情報を<info></info>で括ってください。
               PROMPT
             end

    begin
      response = ChatgptService.call(prompt)
      @fetch_ai.response = response
      if @fetch_ai.save
        save_last_fetch_ai_params if prompt_type == 'personalized'
        respond_to do |format|
          format.json { render json: { redirect_url: fetch_ai_path(@fetch_ai) } }
          format.html do
            redirect_to fetch_ai_path(@fetch_ai),
                        notice: t('defaults.flash_message.fetched', item: FetchAi.model_name.human)
          end
        end
      else
        respond_to do |format|
          format.json do
            render json: { alert: t('defaults.flash_message.not_fetched', item: FetchAi.model_name.human) },
                   status: :unprocessable_entity
          end
          format.html do
            redirect_to root_path, alert: t('defaults.flash_message.not_fetched', item: FetchAi.model_name.human)
          end
        end
      end
    rescue Net::ReadTimeout, StandardError => e
      logger.error "Failed to call OpenAI: #{e.message}"
      respond_to do |format|
        format.json do
          render json: { alert: t('defaults.flash_message.not_fetched', item: FetchAi.model_name.human) },
                 status: :unprocessable_entity
        end
        format.html do
          redirect_to root_path, alert: t('defaults.flash_message.not_fetched', item: FetchAi.model_name.human)
        end
      end
    end
  end

  def edit; end

  def update; end

  def destroy
    @fetch_ai = FetchAi.find(params[:id])
    if @fetch_ai.destroy
      redirect_to request.referer || fetch_ais_url,
                  notice: t('defaults.flash_message.destroy', item: FetchAi.model_name.human)
    else
      redirect_to fetch_ai_path(@fetch_ai),
                  alert: t('defaults.flash_message.not_destroy', item: FetchAi.model_name.human)
    end
  end

  private

  def fetch_ai_params
    params.fetch(:fetch_ai, {}).permit(:prompt_type, :popularity, :quote_type, :mood, :schedule, :how)
  end

  def set_fetch_ai
    @fetch_ai = FetchAi.find(params[:id])
  end

  def save_last_fetch_ai_params
    session[:last_fetch_ai_params] = fetch_ai_params if user_signed_in?
  end
end
