class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.string :title
      t.text :notes
      t.datetime :due_date
      t.integer :admin_id

      t.timestamps null: false
    end
  end
end
