require 'rails_helper'
RSpec.describe '商品閲覧機能', type: :system do
  let!(:display_food) { create(:food, :displayable, :attach_image) }
  let!(:undisplay_food) { create(:food, name: 'だいこん', price: 500) }

  describe '商品一覧' do
    it '公開中の商品が一覧画面に表示される' do
      visit root_path
      within :test_id, dom_id(display_food) do
        expect(page).to have_css 'img[src$="cherry.jpg"]'
        expect(page).to have_content 'にんじん'
        expect(page).to have_content '110円（税込）'
      end
    end

    it '非公開の商品は一覧画面に表示されない' do
      visit root_path
      expect(page).not_to have_css 'img[src$="no-img.jpg"]'
      expect(page).not_to have_content 'だいこん'
      expect(page).not_to have_content '550円（税込）'
    end
  end

  describe '商品詳細' do
    let(:food) { create(:food, :displayable, :attach_image) }

    it 'ログインなしで商品詳細が閲覧できる' do
      visit food_path(food)
      expect(page).to have_current_path food_path(food)
      expect(page).to have_css 'img[src$="cherry.jpg"]'
      expect(page).to have_content 'にんじん'
      expect(page).to have_content '110円（税込）'
      expect(page).to have_content '美味しい'
    end
  end
end
