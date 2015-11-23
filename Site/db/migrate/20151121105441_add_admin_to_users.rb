class AddAdminToUsers < ActiveRecord::Migration
  def change
    #добавляем поле-метку определения админа для сайта
    add_column :users, :admin, :boolean, default: false
  end
end
