class RemoveAdminFromTicket < ActiveRecord::Migration
  def change
  	remove_reference :tickets, :admin, index: true, foreign_key: true
  end
end