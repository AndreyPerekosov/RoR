class CommentsController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show] #это - фильтры
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:edit, :destroy, :update] #не забываем при 
  # валидации user валидировать  #update тоже, иначе дырка в безопасности 
  
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id]) #загружаем нужный пост для этого и нужен вложенный ресурс
    @comment = Comment.new(comment_params)
    @comment.post = @post #связываем пост и комментарий
    @comment.user = current_user
    #current_user вернет nil если не требовать аунтификации пользвателя
      if @comment.save
        redirect_to @post, notice: t(:comment_created)
      else
        render :new 
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: t(:comment_updated) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: t(:comment_delete) #используем удаленный из базы коммент, но еще существующий
    #в пространству памяти для перенаправления на родительский пост
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    def validate_user
      if !((current_user && current_user.id == @comment.user.id) || current_user.admin?) #можно проще unless @post.user == current_user
        redirect_to 'welcome/index', notice: 'Нет прав'
      end
    end
end
