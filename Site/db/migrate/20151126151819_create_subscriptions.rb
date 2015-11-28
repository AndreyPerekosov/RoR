class CreateSubscriptions < ActiveRecord::Migration 
  def change
    #сщздаем промежуточную таблицу т.к. у нас связь типа многие ко многим (юсеры имеют много подисок, и посты имеют много подписчиков)
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :post, index: true
      
      t.timestamps null: false
    end
  end
end
