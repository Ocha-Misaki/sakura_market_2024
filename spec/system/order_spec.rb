require 'rails_helper'
RSpec.describe '注文機能', type: :system do
  let(:user) { create(:user) }
  let!(:address) { create(:address, user:) }

  context 'ログイン時' do
    before do
      sign_in user
    end

    describe '注文作成機能' do
      let(:food) { create(:food, :displayable, :attach_image) }
      let(:cart) { create(:cart, user:) }
      let!(:cart_item) { create(:cart_item, cart:, food:) }

      context 'カート内商品が全て注文可能な時' do
        it '注文できる' do
          visit cart_path

          click_link 'レジに進む'
          expect(page).to have_current_path new_order_path
          expect(page).to have_content 'レジ'
          within :test_id, dom_id(cart, :cart_item_detail) do
            expect(page).to have_content 'にんじん'
            expect(page).to have_content '110円'
            expect(page).to have_content '1'
          end
          within :test_id, dom_id(cart, :total_cash_detail) do
            expect(page).to have_content '配送料: 600円'
            expect(page).to have_content '代引き手数料: 300円'
            expect(page).to have_content '合計点数: 1個'
            expect(page).to have_content '合計: 1,010円'
          end

          travel_to Date.new(2024, 3, 10) do
            today = Date.current
            first_business_days = (today + 4.days).to_date
            select "#{first_business_days}", from: '配送日'
            select '8:00-12:00', from: '配送時間'
            fill_in '宛名', with: '田中太郎'
            fill_in 'お届け住所', with: '神奈川県鎌倉市'
            expect do
              click_button '注文する'
            end.to change(Order, :count).by(1)
          end
        end
      end

      context 'カートの商品が注文不可の場合' do
        let(:undisplayable_food) { create(:food) }
        let(:cart) { create(:cart, user:) }
        let!(:cart_item) { create(:cart_item, cart:, food: undisplayable_food) }

        it '注文できない' do
          visit cart_path
          expect(page).to have_selector 'button[class~="disabled"]', text: 'レジに進む'
        end
      end
    end

    describe '注文履歴閲覧機能' do
      let(:food) { create(:food, :displayable, :attach_image) }
      let(:order) { create(:order, user:) }
      let!(:order_item) { create(:order_item, food:, order:) }

      it '一覧が閲覧できる' do
        visit orders_path
        expect(page).to have_current_path orders_path
        rows = all('[data-test-id=order-table] tbody tr')
        expect(rows.size).to eq 1
        within rows[0] do
          expect(page).to have_content I18n.l(order.created_at)
          expect(page).to have_content '1,010円'
          expect(page).to have_content '2024/03/29 8:00-12:00'
          expect(page).to have_content 'テスト太郎'
          expect(page).to have_content '東京都大田区田園調布'
          expect(page).to have_link '詳細', href: order_path(order)
        end
      end

      it '詳細が閲覧できる' do
        visit order_path(order)
        expect(page).to have_content I18n.l(order.created_at)
        expect(page).to have_content '1,010円'
        expect(page).to have_content '2024/03/29 8:00-12:00'
        expect(page).to have_content 'テスト太郎'
        expect(page).to have_content '東京都大田区田園調布'
        expect(page).to have_content '3個'
        expect(page).to have_content '1,010円'
        within :test_id, dom_id(order, :order_item_detail) do
          expect(page).to have_content 'にんじん'
          expect(page).to have_content '110円'
          expect(page).to have_content '1'
          expect(page).to have_content '110円'
        end
      end
    end
  end
end
