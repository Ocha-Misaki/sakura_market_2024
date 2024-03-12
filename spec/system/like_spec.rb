require 'rails_helper'
RSpec.describe 'いいね機能', type: :system do
  let(:user) { create(:user) }

  context 'ログイン時' do
    before do
      sign_in user
    end

    describe 'いいね作成' do
      context '自分の投稿の場合' do
        let!(:my_post) { create(:post, :attach_image, user:) }

        it 'いいねできない' do
          visit root_path
          within :test_id, dom_id(my_post) do
            expect(page).to have_content '美味しいです'
            expect(page).to have_content I18n.l(my_post.created_at)
            expect(page).to have_content 'test@email.com'
            expect(page).to have_content '美味しいのでおすすめです'
            expect(page).to have_css 'img[src$="cherry.jpg"]'
            expect(page).not_to have_selector :test_id, dom_id(my_post, :like)
          end
        end
      end

      context '他人の投稿の場合' do
        let(:other) { create(:user, :other_user) }
        let!(:other_post) { create(:post, :attach_image, user: other) }

        it 'いいねできる' do
          visit root_path
          within :test_id, dom_id(other_post) do
            expect(page).to have_content '美味しいです'
            expect(page).to have_content I18n.l(other_post.created_at)
            expect(page).to have_content 'other@email.com'
            expect(page).to have_content '美味しいのでおすすめです'
            expect(page).to have_css 'img[src$="cherry.jpg"]'
            expect(page).to have_selector :test_id, dom_id(other_post, :like)
          end

          button = find('.like-btn')
          expect do
            assert_emails 1 do
              button.click
            end
          end.to change(Like, :count).by(1)
        endw
      end
    end

    describe 'いいね削除機能' do
      context '他人の投稿の場合' do
        let(:other) { create(:user, :other_user) }
        let!(:other_post) { create(:post, :attach_image, user: other) }
        let!(:like) { create(:like, user:, post: other_post) }

        it 'いいね削除できる' do
          visit root_path
          within :test_id, dom_id(other_post) do
            expect(page).to have_content '美味しいです'
            expect(page).to have_content I18n.l(other_post.created_at)
            expect(page).to have_content 'other@email.com'
            expect(page).to have_content '美味しいのでおすすめです'
            expect(page).to have_css 'img[src$="cherry.jpg"]'
            expect(page).to have_selector :test_id, dom_id(other_post, :like)
          end
          button = find('.like-btn')
          expect do
            button.click
          end.to change(Like, :count).by(-1)
        end
      end
    end
  end
end
