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
    @fetch_ai = FetchAi.new
    @fetch_ai.user = current_user if user_signed_in? # ログインしていればユーザーを設定

    prompt = <<~PROMPT
      名言や格言と言われるものを、映画、書籍、漫画、アニメ等から１つ引用してください。
      引用作品名、作者、登場人物名を記載してください。
      引用情報のみで、対話型の返答は省き、日本語でお願いします。
    PROMPT

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
end
