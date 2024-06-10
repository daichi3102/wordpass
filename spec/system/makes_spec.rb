require 'rails_helper'

RSpec.describe 'Makes', type: :system do
  let(:user) { create(:user, name: 'ラッコ', email: 'meigenotter@example.com', password: 'password') }
  let(:another_user) { create(:user, email: 'another@example.com') }

  before do
    driven_by(:rack_test)
  end

  describe '名言作成' do
    context 'サインインしている場合' do
      before do
        login_as(user)
      end

      context '上の句も下の句もcontentが空の場合' do
        it '名言作成はできない' do
          visit makes_path
          click_button '名言作成' # モーダルを開くボタンのテキスト

          within '#make_modal' do
            click_button '作成する', match: :first
          end
        end
      end

      context '上の句または下の句のみcontentがある場合' do
        it '上の句が空で、下の句がある場合名言作成ができる' do
          visit makes_path
          click_button '名言作成' # モーダルを開くボタンのテキスト

          within '#make_modal' do
            fill_in 'make_first_part_attributes_content', with: ''
            fill_in 'make_second_part_attributes_content', with: '下の句の内容'
            click_button '作成する', match: :first
          end

          expect(page).to have_content '下の句の内容'
        end

        it '下の句が空で、上の句がある場合名言作成ができる' do
          visit makes_path
          click_button '名言作成' # モーダルを開くボタンのテキスト

          within '#make_modal' do
            fill_in 'make_first_part_attributes_content', with: '上の句の内容'
            fill_in 'make_second_part_attributes_content', with: ''
            click_button '作成する', match: :first
          end

          expect(page).to have_content '上の句の内容'
        end
      end

      context '上の句も下の句もcontentがある場合' do
        it '名言作成ができる' do
          visit makes_path
          click_button '名言作成' # モーダルを開くボタンのテキスト

          within '#make_modal' do
            fill_in 'make_first_part_attributes_content', with: '上の句の内容'
            fill_in 'make_second_part_attributes_content', with: '下の句の内容'
            click_button '作成する', match: :first
          end

          expect(page).to have_content '上の句の内容'
          expect(page).to have_content '下の句の内容'
        end
      end

      context '名言作成一覧ページ' do
        it '自分が作成していない名言には、詳細を見るボタンが表示されない' do
          create(:make, first_part: create(:first_part, content: '他人の上の句', user: another_user), second_part: create(:second_part, content: '他人の下の句', user: another_user))
          visit makes_path
          expect(page).not_to have_link '詳細を見る'
        end

        it '詳細を見るボタンを押すとshowページが表示される' do
          make = create(:make, first_part: create(:first_part, content: '上の句', user: user), second_part: create(:second_part, content: '下の句', user: user))
          
          # showページに直接遷移
          visit make_path(make)
        
          expect(page).to have_content '上の句'
          expect(page).to have_content '下の句'
        end
      end

      describe '詳細ページ' do
        it 'フォームから上の句と下の句のcontentの更新や削除ができる' do
          make = create(:make, first_part: create(:first_part, content: '上の句', user: user), second_part: create(:second_part, content: '下の句', user: user))
          visit make_path(make)
          click_button '編集', match: :first
          fill_in 'make_first_part_attributes_content', with: '更新された上の句'
          fill_in 'make_second_part_attributes_content', with: '更新された下の句'
          click_button '更新する'
          expect(page).to have_content '更新された上の句'
          expect(page).to have_content '更新された下の句'
        end
      end
    end

    context 'サインインしていない場合' do
      it '名言作成ボタンが表示されない' do
        visit makes_path
        expect(page).not_to have_button '名言作成'
      end
    end
  end
end
