class AddTaskStatusToToDo < ActiveRecord::Migration
  def change
  	add_column :to_dos, :task_status, :boolean
  end
end