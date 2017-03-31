class RenameKeysInSoftware < ActiveRecord::Migration
 
  def change
    rename_column :softwares, :public_key, :software_key
    rename_column :softwares, :secret_key, :api_key
  end
  
end
