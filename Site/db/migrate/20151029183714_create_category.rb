class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :body
      t.timestamps
    end
  end
end
