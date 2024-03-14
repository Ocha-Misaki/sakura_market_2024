class Posts::LikesController < Users::ApplicationController
  before_action :set_post

  def create
    current_user.likes.create!(post: @post)
    LikeMailer.like_confirmation(@post).deliver_later
    redirect_to root_path, notice: 'Goodしました'
  end

  def destroy
    @like = current_user.likes.find_by(post: @post)
    @like.destroy!
    redirect_to root_path, alert: 'Goodを取り消しました', status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
