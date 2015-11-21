class PostsController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show] #требуем аунтификацию для всего кроме показать и список
  before_action :set_post, only: [:show, :edit, :update, :destroy, :validate_user] #Важно! Фильтры выполнятются в порядке следования
  before_action :validate_user, only: [:edit, :destroy, :update]
  

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 кроме
  # GET /posts/1.json
  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params) #создаваемый пост привязываем к текущему юсеру

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, category_ids: []) 
      #:category_ids: [] - ожидаем ввода массива id категорий, т.к их может быть более одной
    end

    def validate_user
      if !(current_user && current_user.id == @post.user.id) #можно проще unless @post.user == current_user но это будет затратней по ресурсам
        #т.к. не грузим целый объект, а не поле с id Так что здесь лучше по id работать. Проверка current_user
        # это проверка на существование current_user, иначе, если не залогинин user, то при сравнении выдаст ошибку, т.к. 
        # т.к. current_user будет возвращать nill
        redirect_to 'welcome/index', notice: 'Нет прав'
      end
    end   
   
 

end
