class Category < ActiveRecord::Base
  validates :body, presence: true
end