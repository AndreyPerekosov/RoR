class Admin::BaseController < ApplicationController #так как данный файл лежит в папке Admin
  before_action :authenticate_user!
  before_action :check_admin

  layout 'admin' #указываем админский шаблон 

  protected

    def check_admin
      unless current_user.admin? #метод - предикат для поля атоматически добавляется, если у нас поле типа boolean
        redirect_to root_path, #путь на корневую дерикторию 
                              alert: 'У вас нет прав на просмотр данной страницы' #с помощью flash выводим сообщение (тоже само, что flash[:alert])
                              # flash сохраняет сообщение для следущего запроса
                              # flash.now для текущего       
      end         
    end


end