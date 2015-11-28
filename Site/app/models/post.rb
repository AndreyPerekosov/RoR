class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  
  has_many :comments, dependent: :destroy #при такой записи при удалении поста, удаляются и комментарии, а лежат мусором в БД
  #если destroy, то комменты удаляются с работой соответсвующих колбэков
  #усли delete, то удаляются скопом, без срабатываения вспомогательных процедур
  has_many :categories_posts
  has_many :categories, through: :categories_posts

  has_many :posts_tags
  has_many :tags, through: :posts_tags

  belongs_to :user

  #создаем ассоциацию для подписок

  has_many :subscriptions
  has_many :subscribers, source: :user,  through: :subscriptions 
  #(:subscribers, source: :user, - переопределяем имя, так написали,чтобы 
  #не писать has_many :users, что может привести к путанице, т.к. у нас есть belongs_to :user)



#scope может создавать новые методы
#изменяем порядок следования постов с помощью sope и применяя лямбда-выражение.

  scope :reverse_order, -> (order) { order(created_at: order) } #scope с параметром
#теперь мы можем написать Post.reverse_order.all и у нас выведется все в обратном порядке
#scope может применяться как метод класса (глобально ко всей таблице) либо
#применить к ассоциации, например user.posts.reverse_order.all - посты будут выводится в обратном порядке
#можно передавать параметры  scope :reverse_order, -> (order){ order(created_at: order) }
#теперь, написав к примеру Post.reverse_order(:asc).all мы можем управлять, в каком порядке отображать посты
#scope может склеиваться XXXXXX.sdf.fgjk.sdio.all etc (после all уже нет scope, т. к. all  это сам запрос (запрос ActiveRecord)
#который формируются в SQL-запрос к БД а scope формирует параметры запроса, 
#то после запроса нет смысла формировать еще какие либо параметры )
#применяем scope для фильтрации постов на опубликованные и нет (по добавленному в таблицу :posts полю :pudlished) 
  scope :published, -> {where(published: true)}
  scope :unpublished, -> {where(published: false)}

  #делаем callback, чтобы автоматически подписать автора на пост
  after_create :subscribe_author

  protected

  def subscribe_author
    #здесь для краткости опускаем self (походу так можно)
    user.subscribed_to(self) #привязываем только что созданный пост к автору (subscribed_to - метод написан в User)
  end
end
