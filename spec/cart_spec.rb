require 'rails_helper'
RSpec.describe 'カート機能', type: :system do
  let(:user) { create(:user) }
  let(:food) { create(:food, :displayable, :attach_image) }

  context 'ログイン時' do
    before do
      sign_in user
    end

    describe 'カート商品追加' do
      context 'カート未追加の場合'
      it '商品をカートに追加できる' do
        visit food_path(food)
        fill_in 'quantity', with: 2
        expect do
          click_button 'カートに入れる'
        end.to change(CartItem, :count).by(1)

        visit cart_path
        cart = Cart.last
        within :test_id, dom_id(cart) do
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).to have_content 'にんじん'
          expect(page).to have_content '2'
          expect(page).to have_button '更新する'
          expect(page).to have_button '削除する'
          expect(page).to have_content '2個'
          expect(page).to have_content '220円'
        end
      end

      context 'カート追加済みの場合' do
        let(:cart) { create(:cart, user:) }
        let!(:cart_item) { create(:cart_item, cart:, food:, quantity: 1) }

        it 'カート追加したら、個数のみが変更する' do
          visit food_path(food)
          fill_in 'quantity', with: 3
          expect do
            click_button 'カートに入れる'
          end.not_to change(CartItem, :count)

          visit cart_path
          cart = Cart.last
          within :test_id, dom_id(cart) do
            expect(page).to have_css 'img[src$="cherry.jpg"]'
            expect(page).to have_content 'にんじん'
            expect(page).to have_content '4'
            expect(page).to have_button '更新する'
            expect(page).to have_button '削除する'
            expect(page).to have_content '4個'
            expect(page).to have_content '440円'
          end
        end
      end
    end

    describe 'カート商品編集' do
      let(:cart) { create(:cart, user:) }
      let!(:cart_item) { create(:cart_item, cart:, food:, quantity: 1) }

      it 'カート詳細から個数の変更ができる' do
        visit cart_path
        within :test_id, dom_id(cart) do
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).to have_content 'にんじん'
          expect(page).to have_content '1'
          expect(page).to have_button '更新する'
          expect(page).to have_button '削除する'
          expect(page).to have_content '1個'
          expect(page).to have_content '110円'
        end

        fill_in 'cart_item[quantity]', with: 2
        expect do
          click_button '更新する'
        end.not_to change(CartItem, :count)

        within :test_id, dom_id(cart) do
          expect(page).to have_content 'にんじん'
          expect(page).to have_content '2'
          expect(page).to have_content '2個'
          expect(page).to have_content '220円'
        end
      end

      describe 'カート商品削除' do
        let(:cart) { create(:cart, user:) }
        let!(:cart_item) { create(:cart_item, cart:, food:, quantity: 1) }

        it 'カート詳細から商品を削除できる' do
          visit cart_path
          within :test_id, dom_id(cart) do
            expect(page).to have_css 'img[src$="cherry.jpg"]'
            expect(page).to have_content 'にんじん'
            expect(page).to have_content '1'
            expect(page).to have_button '更新する'
            expect(page).to have_button '削除する'
            expect(page).to have_content '1個'
            expect(page).to have_content '110円'
          end

          expect do
            click_button '削除する'
          end.to change(CartItem, :count).by(-1)
          expect(page).not_to have_css 'img[src$="cherry.jpg"]'
          expect(page).not_to have_content 'にんじん'
          expect(page).not_to have_content '1'
          expect(page).not_to have_button '更新する'
          expect(page).not_to have_button '削除する'
          expect(page).not_to have_content '1個'
          expect(page).not_to have_content '110円'
        end
      end
    end
  end
end
