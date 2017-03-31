class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.integer :software_id
      t.string :software_key
      t.date :expiration_date
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
