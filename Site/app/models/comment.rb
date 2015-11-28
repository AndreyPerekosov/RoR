class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, :post_id, presence: true # валидация присутствия внешнего ключа
  
  # добавляем ассоциации
  belongs_to :post
  belongs_to :user
  #добавляем callback, чтобы после сохранения поста авто высылалось письмо о посте
  #callback обычно пишутся в модели, т. к. это бизнес логика
  after_save :send_notification # будет отправляться всегда. Если after_create - только после создания
  

  private

  def send_notification #метод для callback
    #здесь для краткости опускаем self (походу так можно)
    post.subscribers.each do |user| #можно использовать find_each - загружает по 1000 записей (а не все сразу), если есть сомнения, что памяти не хватит
      NotificationMailer.comment_notification(user, post, self).deliver_now #здесь мы инстанс метод вызываем как метод класса, это сделано
      #специально, чтобы можно быстро отправлять письма. Формируется объект. Метод deliver_now отправляет письмо
      #self - это объект коммента
    end
  end   

end
