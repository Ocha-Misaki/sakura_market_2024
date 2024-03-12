class Posts::CommentsController < Users::ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[edit update destroy]

  def index
    @comments = @post.comments
                     .default_order
                     .page(params[:page])
  end

  def new
    @comment = current_user.comments.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save!
      redirect_to root_path, notice: 'コメントしました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to root_path, notice: 'コメントを編集しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path, alert: 'コメントを削除しました'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = current_user.comments.find_by(post: @post)
  end

  def comment_params
    params.require(:comment).permit(:text).merge(post: @post)
  end
end
