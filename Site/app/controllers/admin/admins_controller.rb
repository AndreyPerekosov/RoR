class Admin::AdminsController < Admin::BaseController 

  def index
    render 'admin/admin'
  end

end