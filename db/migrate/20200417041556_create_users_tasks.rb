class CreateUsersTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :users_tasks do |t|
      t.interger :user_id
      t.interger :task_id
      t.timestamps null: false
    end
  end
end
