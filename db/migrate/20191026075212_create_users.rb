class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :_name
      t.text :_desctiption


      t.timestamps
    end
  end
end
