class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.boolean :status
      t.text :solution

      t.timestamps null: false
    end
  end
end
