# spec/system/fetch_ais_spec.rb

require 'rails_helper'

RSpec.describe "FetchAis", type: :system do
  let(:user) { create(:user, name: 'ラッコ', email: 'meigenotter@example.com', password: 'password') }

  before do
    driven_by(:rack_test)
  end

  describe "AIによる名言の自動生成" do
    context "サインインしている場合" do
      before do
        login_as(user)
      end

      it "AIが新しい名言を生成し、その詳細ページにリダイレクトされる" do
        visit root_path
        click_button '条件を指定して受け取る' # モーダルを開くボタンのテキスト

        within '#my_modal_2' do # モーダルのIDを指定
          select '楽しい', from: 'fetch_ai_mood'
          select '仕事', from: 'fetch_ai_schedule'
          select '心に刺さる名言', from: 'fetch_ai_how'
          select 'メジャーでもマイナーでもないような', from: 'fetch_ai_popularity'
          select '有名人', from: 'fetch_ai_quote_type'
          click_button '受け取る' # モーダル内のボタンテキストを指定
        end

        expect(page).to have_content 'AIからの名言を受け取ったよ'

        # FetchAiオブジェクトのresponseが空でないことを確認する
        fetch_ai = FetchAi.last
        expect(fetch_ai.response).to be_present
      end

      it "すぐに受け取るボタンをクリックしてAIが名言を自動生成する" do
        visit root_path
        click_button 'すぐに受け取る' # すぐに受け取るボタンのテキスト

        expect(page).to have_content 'AIからの名言を受け取ったよ'

        # FetchAiオブジェクトのresponseが空でないことを確認する
        fetch_ai = FetchAi.last
        expect(fetch_ai.response).to be_present
      end
    end

    context "サインインしていない場合" do
      it "条件を指定して受け取るボタンが表示されない" do
        visit root_path
        expect(page).not_to have_button '条件を指定して受け取る'
      end

      it "すぐに受け取るボタンをクリックしてAIが名言を自動生成する" do
        visit root_path
        click_button 'すぐに受け取る' # すぐに受け取るボタンのテキスト

        expect(page).to have_content 'AIからの名言を受け取ったよ'

        # FetchAiオブジェクトのresponseが空でないことを確認する
        fetch_ai = FetchAi.last
        expect(fetch_ai.response).to be_present
      end
    end
  end
end
