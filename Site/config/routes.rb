Rails.application.routes.draw do
  devise_for :users
  resources :posts do 
    resources :comments, shallow: true #метод shallow для процедуры удаления, редактирования... >
    # > указывает ресурс как не вложенный и можно обращаться на прямую, минуя родительсий ресурс
  end
  
  resources :categories, only: :show #Чтобы запрос дальше роутинга не шел указываем что есть маршрут
    #  только для #show  -> categories, only: :show - создаст маршрут только для #show
    # для нескольких - массив resources :categories, only: [:show, :edit]. Для одиночного также можно массив
  root 'welcome#index'

  #<*********** административная часть *************************>
 
  
  namespace :admin do #пространство имен для админа
    resources :categories, :posts, :comments, :users
    get '/' => 'admins#index'  #главный вид для админа

  end

end
