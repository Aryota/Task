class CreateAddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :add_admin_to_users do |t|
      add_column :users, :admin, :boolean, default: false, null: false
    end
  end
end
