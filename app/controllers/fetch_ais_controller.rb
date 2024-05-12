class FetchAisController < ApplicationController
  def index
  end

  def show
    @fetch_ai = FetchAi.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
    @fetch_ai = FetchAi.new(fetch_ai_params)
    @fetch_ai.user = current_user if user_signed_in? # ログインしていればユーザーを設定

    # prompt_type パラメータに基づくプロンプトの選択
    prompt = case params[:prompt_type]
             when 'personalized'
               if user_signed_in?
                 <<~PROMPT
                   今は#{current_user.age}歳で、今日は#{current_user.schedule}をして過ごす予定です。
                   #{current_user.how}を、#{current_user.popularity}な#{current_user.quote_type}から1つ引用してください。
                   引用作品名、作者、登場人物名を記載してください。
                   引用情報のみで、対話型の返答は省き、日本語でお願いします。
                 PROMPT
               end
             else # 'general' またはログインしていない場合
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
