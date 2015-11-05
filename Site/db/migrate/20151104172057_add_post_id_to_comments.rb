class AddPostIdToComments < ActiveRecord::Migration
  def change
    add_belongs_to :comments, :post, index: true
  end
end
