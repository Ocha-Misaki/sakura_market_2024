require 'rails_helper'
RSpec.describe 'アドレス作成機能', type: :system do
  let(:user) { create(:user) }

  context 'ログイン時' do
    before do
      sign_in user
    end

    describe 'アドレス新規作成' do
      it 'アドレスを一件新規作成できる' do
        visit new_address_path
        expect(page).to have_current_path new_address_path

        fill_in 'address_address_name', with: 'テスト太郎'
        fill_in 'address_location', with: '東京都大田区田園調布'
        expect do
          click_button '登録する'
        end.to change(Address, :count).by(1)

        visit address_path
        expect(page).to have_content 'テスト太郎'
        expect(page).to have_content '東京都大田区田園調布'
        expect(page).not_to have_link '新規作成', href: new_address_path
        expect(page).to have_link '編集する'
      end
    end

    describe 'アドレス編集' do
      let!(:address) { create(:address, user:) }

      it '登録住所を編集できる' do
        visit edit_address_path
        expect(page).to have_current_path edit_address_path

        fill_in 'address_address_name', with: 'テスト次郎'
        fill_in 'address_location', with: '東京都大田区'
        expect do
          click_button '更新する'
        end.not_to change(Address, :count)

        visit address_path
        expect(page).to have_content 'テスト次郎'
        expect(page).to have_content '東京都大田区'
      end
    end
  end
end
