require 'rails_helper'
RSpec.describe '管理者ログイン機能', type: :system do
  let(:admin) { create(:admin) }

  describe '未ログイン時' do
    it '管理者ログイン画面にアクセスできる' do
      visit new_admin_session_path
      expect(page).to have_content '管理者ログイン'
      expect(page).to have_content 'メールアドレス'
      expect(page).to have_content 'パスワード'
      expect(page).to have_content 'ログイン情報を記憶する'
      expect(page).to have_button 'ログインする'
    end
  end

  describe 'ログイン時' do
    before do
      sign_in admin
    end

    it '管理者画面にアクセスできる' do
      visit admin_root_path
      expect(page).to have_current_path admin_root_path
      expect(page).to have_button '管理者ログアウト'
    end
  end
end
