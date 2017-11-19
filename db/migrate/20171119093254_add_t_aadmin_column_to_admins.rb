class AddTAadminColumnToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :TAadmin, :boolean
  end
end
