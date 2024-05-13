class FetchAisController < ApplicationController
  before_action :authenticate_user!, only: %i[index destroy]

  def index
    @fetch_ais = current_user.fetch_ais
  end

  def show
    @fetch_ai = FetchAi.find(params[:id])
  end

  def new
  end

  def edit
  end

  def destroy
    @fetch_ai = current_user.fetch_ais.find(params[:id])
    @fetch_ai.destroy
    redirect_to fetch_ais_path, notice: 'FetchAi was successfully destroyed.'
  end

  def create
    @fetch_ai = FetchAi.new(fetch_ai_params) # オブジェクトの初期化
    @fetch_ai.user = current_user if user_signed_in? # ログインしていればユーザーを設定

    fetch_ai_data = params.fetch(:fetch_ai, {})
    prompt_type = fetch_ai_data[:prompt_type]
    # prompt_type パラメータに基づくプロンプトの選択
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
                   #{how}を、#{popularity}な#{quote_type}から1つ引用してください。
                   偉人や有名人の場合は、名前を記載してください。
                   書籍、映画、漫画、アニメの場合には引用作品名と、作者か登場人物名を記載してください。
                   対話型の返答は省き、引用情報のみの日本語でお願いします。
                 PROMPT
               end
             else # ログインしていない場合
               <<~PROMPT
                 名言や格言と言われるものを、映画、書籍、漫画、アニメ等から１つ引用してください。
                 引用作品名、作者、登場人物名を記載してください。
                 引用情報のみで、対話型の返答は省き、日本語でお願いします。
               PROMPT
             end
    begin
      response = ChatgptService.call(prompt)
      @fetch_ai.response = response
      if @fetch_ai.save
        redirect_to fetch_ai_path(@fetch_ai), notice: t('defaults.flash_message.fetch_ai')
      else
        redirect_to root_path, alert: '保存に失敗しました。' + @fetch_ai.errors.full_messages.to_sentence
      end
    rescue Net::ReadTimeout, StandardError => e
      logger.error "Failed to call OpenAI: #{e.message}"
      redirect_to root_path, alert: t('defaults.flash_message.not_fetch_ai')
    end
  end

  private

  def fetch_ai_params
    params.fetch(:fetch_ai, {}).permit(:prompt_type, :popularity, :quote_type, :mood, :schedule, :how)
  end
end
