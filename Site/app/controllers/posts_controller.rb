class PostsController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show] #требуем аунтификацию для всего кроме показать и список
  before_action :set_post, only: [:show, :edit, :update, :destroy, :validate_user, :publish, :unpublish] #Важно! Фильтры выполнятются в порядке следования
  before_action :validate_user, only: [:edit, :destroy, :update]
  

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.reverse_order(:desc).published.all
    render 'published'
  end
  
  def unpublished  #метод для отображения не опубликованных постов
    @posts = Post.reverse_order(:desc).unpublished.all
  end
  
  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new #создаем переменную (она же объект в ror) для формы _form.html.erb
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params) #создаваемый пост привязываем к текущему юсеру
    #здесь опять идет создание переменной т.к. как в #new, но уже с параметрами
    #создаем два раза т.к. переменная @post между http-запросами не сохраняются. 

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: t(:post_created) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: t(:post_updated) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: t(:post_delete) }
    end
  end

  def publish
   @post.published = true
   redirect_to unpublished_posts_path if @post.save  
  end

 def unpublish
  @post.published = false
  redirect_to posts_path if @post.save 
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published, category_ids: []) 
      #:category_ids: [] - ожидаем ввода массива id категорий, т.к их может быть более одной
    end

    def validate_user
      unless current_user.owner_of?(@post)
        redirect_to :root, notice: 'Нет прав'
      end
    end

end