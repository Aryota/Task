class AddClomnTermAndPriorityToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :start_at, :datetime
    add_column :tasks, :end_at, :datetime
    add_column :tasks, :priority, :integer
  end
end
