class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments

  has_many :subscriptions
  has_many :subscribed_posts, source: :post, through: :subscriptions #здесь source определяет имя истоника связи
  #т.к.мы переопределяем имя называя не :posts, а :subscribed_post
 

  #можно в модели написать индентификацию юзера
  def owner_of?(object)
    id == object.user_id || admin?
  end
  #после этого, например, в контроллере поста можно вызывать у юсера, как инстанс-метод, например current_user.author_of?(@post)

  #здесь пишем метод проверки поста, для того, чтобы менять ссылку подписаться/отписаться
  def subscribed_to?(post)
    # subscribed_posts.include?(post) можно так через стандартный метод, но здесь нужно грузить пост
    !!subscription_for?(post)
    # !! - это преобразование в итсину или ложь, т.к. метод возвращает объект или nil 
  end

  def subscription_for?(post)
    @subscriptions ||= subscriptions.where(post: post).first #делаем через sql - запрос. Здесь where, где ищем, first - возвращает объект
  # ||=  чтобы не делать два запроса, если объект не nil, то новое присваивание не выполняется 
  end

  def subscribed_to(post)
    subscribed_posts << post # subscribed_posts - имя поля
  end
end
