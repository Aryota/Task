class ChageDataIsOwnerToUserstasks < ActiveRecord::Migration[5.2]
  def change
    change_column :users_tasks, :is_owner, :integer
  end
end
