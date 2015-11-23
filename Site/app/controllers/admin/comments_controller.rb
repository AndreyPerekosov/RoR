class Admin::CommentsController < Admin::BaseController
  
  before_action :set_comment
  
  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to  [:admin, @comment.post], notice: 'Комментарий отредактирован'
    else
      render :edit
    end
  end

  
  def destroy
    @comment.destroy
    redirect_to [:admin, @comment.post], notice: 'Комментарий удален'
  end


  private
    
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
     params.require(:comment).permit(:body)
  end

end
