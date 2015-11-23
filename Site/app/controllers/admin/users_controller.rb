class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:destroy]
  def index 
    @users = User.all
  end
  
  def destroy
    unless @user.admin?
      @user.destroy
      redirect_to admin_users_path
    else
      redirect_to admin_users_path, alert: 'Вы не можете удалить администратора'
    end   
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end