Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    get :unpublished, on: :collection #здесь указывается тип запроса, потом имя, и на чем вызывается данный метод (id и коллекция)
    #:member или :collection 
    resources :comments, expect: [:index, :new], shallow: true #метод shallow для процедуры удаления, редактирования... >
    # > указывает ресурс как не вложенный и можно обращаться на прямую, минуя родительсий ресурс
    post :publish, on: :member
    post :unpublish, on: :member

    #ресурс для подписок
    resources :subscriptions, only: [:delete, :destroy, :create], shallow: true 
    # здесь делаем ресурсы для подписок, как вложенные в посты, 
    # т.к. подписка к конкретному посту и у нас уже был готовый id поста из url 
    #(/post/id/subscriptions) и не нужно было его искать
  
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
