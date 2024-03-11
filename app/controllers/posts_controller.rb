class PostsController < Users::ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.default_order
                 .with_attached_image
                 .page(params[:page])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      redirect_to root_path, notice: '新規追加しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to root_path, alert: '削除しました', status: :see_other
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text, :image)
  end
end
