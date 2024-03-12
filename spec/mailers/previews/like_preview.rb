# Preview all emails at http://localhost:3000/rails/mailers/like
class LikePreview < ActionMailer::Preview
  def like_confirmation
    LikeMailer.like_confirmation(Post.first)
  end
end
