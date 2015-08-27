class AlterTicketUpdate < ActiveRecord::Migration
  def change
  	change_column :tickets, :updated_at, :datetime, :null => true
  end
end

