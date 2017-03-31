class CreateSoftwares < ActiveRecord::Migration
  def change
    create_table :softwares do |t|
      t.string :name
      t.string :public_key
      t.string :secret_key
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
