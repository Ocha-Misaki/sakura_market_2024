class LikeMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def like_confirmation(post)
    @post = post
    mail(to: @post.user.email, subject: '投稿にGoodされました')
  end
end
