class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, :post_id, presence: true # валидация присутствия внешнего 
  
  # добавляем ассоциации
  belongs_to :post
  belongs_to :user
end
