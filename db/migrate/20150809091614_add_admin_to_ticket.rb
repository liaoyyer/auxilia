class AddAdminToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :admin, index: true, foreign_key: true
  end
end
