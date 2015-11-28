class Subscription < ActiveRecord::Base #модель для управления подписками пользователей на посты
  belongs_to :user
  belongs_to :post

  validates :user_id, :post_id, presence: true
end
