class ChageUserstasksNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users_tasks, :is_owner, :integer, default: 0
    change_column_null :users_tasks, :is_owner, :integer, null: false
  end

  def down
    change_column :users_tasks, :is_owner, :integer
  end
end
