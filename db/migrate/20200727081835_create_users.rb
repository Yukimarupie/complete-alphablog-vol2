class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.timestamps #created_atなどが自動で追加される
      #passwordカラムはあとから追加する
    end
  end
end
