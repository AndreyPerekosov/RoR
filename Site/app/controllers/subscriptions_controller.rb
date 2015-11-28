#контроллер для подписок
 class SubscriptionsController < ApplicationController
   before_action :authenticate_user!

   def create
    @post = Post.find(params[:post_id]) #т.к. ресурс вложен, то к нам приходит :post_id(родительский ресурс), по нему и ищем 
    current_user.subscribe_to(post) # метод написан в модели User
    redirect_to @post, notice: 'Вы успешно подписаны на пост'  
   end
   
   def destroy
    subscription = Subscription.find(params[:id]) #здесь можно использовать локальными переменными, так они нам нужны только внутри метода
    subscription.destroy if current_user.id == subscription.user_id
    redirect_to subscription.post, notice: 'Вы отписались от обновлений' 
   end
   
 end