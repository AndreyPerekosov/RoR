class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy] 
  
  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to [:admin, @post], notice: 'Пост отредактирован'
    else
      render :edit
    end
  end

  
  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'Пост удален'
  end


  private
    
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, category_ids: []) 
  end

end
