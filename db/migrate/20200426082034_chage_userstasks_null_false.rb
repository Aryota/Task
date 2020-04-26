class ChageUserstasksNullFalse < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :users_tasks, :is_owner, :integer, null: false
    end

    def down
      change_column :users_tasks, :is_owner, :integer
    end
  end
end
