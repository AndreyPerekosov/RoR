class NotificationMailer < ApplicationMailer
  def comment_notification(user, post, comment) #вид должен называться так же. Данный метод отправляет письмо и установить данные
  #(переменные). Они также доступны в виде (правила те же, что и для обычного контроллера) 
    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: 'Новый ответ на ваш пост') #метод указания адреса и темы   
  end 

end
