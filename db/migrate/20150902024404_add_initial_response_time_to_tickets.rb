class AddInitialResponseTimeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :initial_response_time, :datetime
  end
end
