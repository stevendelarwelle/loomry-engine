class RenameSoftwareKeyToLicenseKey < ActiveRecord::Migration
  def change
    rename_column :licenses, :software_key, :license_key
  end
end
