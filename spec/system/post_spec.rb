require 'rails_helper'
RSpec.describe '日記作成機能', type: :system do
  let(:user) { create(:user) }

  context 'ログイン時' do
    before do
      sign_in user
    end

    describe '日記新規作成' do
      it '日記作成できる' do
        visit new_post_path
        expect(page).to have_current_path new_post_path

        fill_in 'post_title', with: '美味しい'
        fill_in 'post_text', with: '美味しいのでおすすめです'
        attach_file 'post_image', Rails.root.join('spec/fixtures/images/cherry.jpg')
        expect do
          click_button '登録する'
        end.to change(Post, :count).by(1)

        visit root_path
        add_post = Post.find_by(title: '美味しい')
        within :test_id, dom_id(add_post) do
          expect(page).to have_content '美味しい'
          expect(page).to have_content I18n.l(add_post.created_at)
          expect(page).to have_content 'test@email.com'
          expect(page).to have_content '美味しいのでおすすめです'
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).to have_link '編集'
          expect(page).to have_button '削除'
        end
      end
    end

    describe '日記編集' do
      let(:other) { create(:user, :other_user) }
      let!(:my_post) { create(:post, :attach_image, user:) }
      let!(:other_post) { create(:post, :attach_image, user: other) }

      it '自分の日記は編集できる' do
        visit root_path
        within :test_id, dom_id(my_post) do
          expect(page).to have_content '美味しいです'
          expect(page).to have_content I18n.l(my_post.created_at)
          expect(page).to have_content 'test@email.com'
          expect(page).to have_content '美味しいのでおすすめです'
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).to have_link '編集', href: edit_post_path(my_post)
          expect(page).to have_button '削除'
        end
        click_link '編集'
        expect(page).to have_current_path edit_post_path(my_post)
        fill_in 'post_title', with: '最高'
        fill_in 'post_text', with: '美味しいので最高です'
        expect do
          click_button '更新する'
        end.not_to change(Post, :count)

        visit root_path
        within :test_id, dom_id(my_post) do
          expect(page).to have_content '最高'
          expect(page).to have_content '美味しいので最高です'
          expect(page).to have_css 'img[src$="cherry.jpg"]'
        end
      end

      it '他の人の日記は編集できない' do
        visit root_path
        within :test_id, dom_id(other_post) do
          expect(page).to have_content '美味しいです'
          expect(page).to have_content I18n.l(other_post.created_at)
          expect(page).to have_content 'other@email.com'
          expect(page).to have_content '美味しいのでおすすめです'
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).not_to have_link '編集', href: edit_post_path(other_post)
        end
      end
    end

    describe '日記削除' do
      let(:other) { create(:user, :other_user) }
      let!(:my_post) { create(:post, user:) }
      let!(:other_post) { create(:post, :other_post, :attach_image, user: other) }

      it '自分の日記を削除できる' do
        visit root_path
        within :test_id, dom_id(my_post) do
          expect(page).to have_content '美味しいです'
          expect(page).to have_content I18n.l(my_post.created_at)
          expect(page).to have_content 'test@email.com'
          expect(page).to have_content '美味しいのでおすすめです'
          expect(page).to have_link '編集', href: edit_post_path(my_post)
          expect(page).to have_button '削除'
        end
        expect do
          click_button '削除'
        end.to change(Post, :count).by(-1)

        visit root_path
        expect(page).not_to have_content '美味しいです'
        expect(page).not_to have_content I18n.l(my_post.created_at)
        expect(page).not_to have_content 'test@email.com'
        expect(page).not_to have_content '美味しいのでおすすめです'
      end

      it '他の人の日記は削除できない' do
        visit root_path
        within :test_id, dom_id(other_post) do
          expect(page).to have_content '最高です'
          expect(page).to have_content I18n.l(other_post.created_at)
          expect(page).to have_content 'other@email.com'
          expect(page).to have_content '美味しいので最高です'
          expect(page).to have_css 'img[src$="cherry.jpg"]'
          expect(page).not_to have_button '削除'
        end
      end
    end
  end
end
