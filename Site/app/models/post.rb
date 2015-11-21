class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  
  has_many :comments
  has_many :categories_posts
  has_many :categories, through: :categories_posts

  has_many :posts_tags
  has_many :tags, through: :posts_tags

  belongs_to :user
end
