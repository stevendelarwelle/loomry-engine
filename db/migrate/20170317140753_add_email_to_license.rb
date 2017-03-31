class AddEmailToLicense < ActiveRecord::Migration
  def change
    add_column :licenses, :email, :string
  end
end
