class AlterTickets < ActiveRecord::Migration
  def change
  	remove_foreign_key(:tickets, :users)
  end
end
