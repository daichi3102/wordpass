# frozen_string_literal: true

FactoryBot.define do
  factory :fetch_ai do
    mood { '楽しい' }
    schedule { '仕事' }
    how { '心に刺さる名言' }
    popularity { 'メジャーでもマイナーでもないような' }
    quote_type { '有名人' }
    response { '勝つ意欲は対して重要ではない。そんなものは誰もが持ち合わせている。重要なのは、勝つために準備をする意欲だ' }
  end
end
