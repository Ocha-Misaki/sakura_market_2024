require 'rails_helper'
RSpec.describe 'ユーザーログイン機能', type: :system do
  let(:user) { create(:user) }

  describe '未ログイン時' do
    it 'ユーザーログイン画面にアクセスできる' do
      visit new_user_session_path
      expect(page).to have_content 'ログイン'
      expect(page).to have_content 'メールアドレス'
      expect(page).to have_content 'パスワード'
      expect(page).to have_content 'ログイン情報を記憶する'
      expect(page).to have_button 'ログインする'
      expect(page).to have_link '新規アカウント登録'
      expect(page).to have_link 'パスワードをお忘れの場合'
      expect(page).to have_link '認証メールを受け取っていない場合'
    end

    it '新規アカウント登録ができる' do
      visit new_user_registration_path
      expect(page).to have_content '新規アカウント登録'
      fill_in 'user_email', with: 'test@email.com'
      fill_in 'user_password', with: 'foobaruser'
      expect do
        click_button '新規登録する'
      end.to change(User, :count).by(1)
    end
  end

  describe 'ログイン時' do
    before do
      sign_in user
    end

    it 'ユーザー画面にアクセスできる' do
      visit root_path
      expect(page).to have_current_path root_path
      expect(page).to have_button 'ログアウト'
    end
  end
end
