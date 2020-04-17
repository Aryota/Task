class CreateUsersTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :users_tasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.timestamps null: false
    end
  end
end
