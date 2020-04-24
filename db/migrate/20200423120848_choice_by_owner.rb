class ChoiceByOwner < ActiveRecord::Migration[5.2]
  def change
    add_column :users_tasks, :is_owner, :string
  end
end
