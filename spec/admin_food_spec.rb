require 'rails_helper'
RSpec.describe '管理者商品作成機能', type: :system do
  let(:admin) { create(:admin) }

  context 'ログイン時' do
    before do
      sign_in admin
    end

    describe '商品新規作成' do
      it '商品作成できる' do
        visit new_admin_food_path
        expect(page).to have_current_path new_admin_food_path

        check '公開する'
        fill_in 'food_name', with: 'にんじん'
        fill_in 'food_price', with: 100
        fill_in 'food_position', with: 1
        fill_in 'food_description', with: '美味しい'
        attach_file 'food_image', Rails.root.join('spec/fixtures/images/cherry.jpg')
        expect do
          click_button '登録する'
        end.to change(Food, :count).by(1)

        visit admin_root_path
        add_food = Food.find_by(name: 'にんじん')
        within :test_id, dom_id(add_food, :admin) do
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).to have_selector :test_id, dom_id(add_food, :displayable), text: '公開中'
          expect(page).to have_content 'にんじん'
          expect(page).to have_content '110円（税込）'
          expect(page).to have_button '←'
          expect(page).to have_button '→'
        end
      end
    end

    describe '商品編集' do
      let(:food) { create(:food, :displayable, :attach_image) }

      it '商品詳細から遷移して、商品編集できる' do
        visit admin_food_path(food)
        expect(page).to have_current_path admin_food_path(food)
        expect(page).to have_link '編集', href: edit_admin_food_path(food)

        visit edit_admin_food_path(food)
        fill_in 'food_name', with: '甘いにんじん'
        fill_in 'food_price', with: 500
        fill_in 'food_position', with: 3
        fill_in 'food_description', with: '美味しくて甘い'

        expect do
          click_button '更新する'
        end.not_to change(Food, :count)

        visit admin_root_path
        within :test_id, dom_id(food, :admin) do
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).to have_selector :test_id, dom_id(food, :displayable), text: '公開中'
          expect(page).to have_content '甘いにんじん'
          expect(page).to have_content '550円（税込）'
          expect(page).to have_button '←'
          expect(page).to have_button '→'
        end
      end
    end

    describe '商品削除' do
      let(:food) { create(:food, :displayable, :attach_image) }

      it '商品を削除できる' do
        visit admin_food_path(food)
        expect(page).to have_current_path admin_food_path(food)

        expect do
          click_button '削除'
        end.to change(Food, :count).by(-1)

        visit admin_root_path
        expect(page).not_to have_css 'img[src$="cherry.jpg"]'
        expect(page).not_to have_content 'にんじん'
        expect(page).not_to have_content '110円（税込）'
        expect(page).not_to have_link '←'
        expect(page).not_to have_link '→'
      end
    end
  end
end
