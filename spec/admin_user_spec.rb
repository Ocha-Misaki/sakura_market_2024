require 'rails_helper'
RSpec.describe '管理者ユーザー管理機能', type: :system do
  let(:admin) { create(:admin) }

  context 'ログイン時' do
    before do
      sign_in admin
    end

    describe 'ユーザー情報閲覧' do
      let!(:user) { create(:user) }

      it 'ユーザー一覧情報を閲覧できる' do
        visit admin_users_path
        expect(page).to have_current_path admin_users_path

        expect(page).to have_content 'ユーザー一覧'
        rows = all('[data-test-id=user-table] tbody tr')
        expect(rows.size).to eq 1
        within rows[0] do
          expect(page).to have_content 'test@email.com'
          expect(page).to have_link '詳細', href: admin_user_path(user)
        end
      end

      it '個別のユーザー情報を参照できる' do
        visit admin_user_path(user)
        expect(page).to have_current_path admin_user_path(user)
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'test@email.com'
        expect(page).to have_link '編集', href: edit_admin_user_path(user)
        expect(page).to have_button '削除'
      end
    end

    describe 'ユーザー編集' do
      let!(:user) { create(:user) }

      it 'ユーザー情報を編集できる' do
        visit edit_admin_user_path(user)
        fill_in 'user_email', with: 'hoge@email.com'
        expect do
          click_button '更新する'
          visit admin_users_path
          rows = all('[data-test-id=user-table] tbody tr')
          within rows[0] do
            expect(page).to have_content 'hoge@email.com'
          end
        end
      end
    end

    describe 'ユーザー削除' do
      let!(:user) { create(:user) }

      it 'ユーザーを削除できる' do
        visit admin_user_path(user)
        expect do
          click_button '削除'
        end.to change(User, :count).by(-1)

        visit admin_users_path
        rows = all('[data-test-id=user-table] tbody tr')
        expect(rows.size).to eq 0
        expect(page).not_to have_content 'test@email.com'
      end
    end
  end
end
