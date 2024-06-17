# frozen_string_literal: true

module ApplicationHelper
  # OGP
  def default_meta_tags
    {
      site: 'MeigenOtter',
      title: 'AIを使った名言提供サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'MeigenOtterを使えば、偉人、有名人、書籍、映画、漫画、アニメなど、様々なジャンルの名言をAIが提供します。',
      keywords: '名言,言葉,生成AI',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('MOogp.PNG'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('MOogp.PNG') # 配置するパスやファイル名によって変更すること
      }
    }
  end

  def unchecked_informations
    current_user.passive_informations.where(checked: false)
  end
end
