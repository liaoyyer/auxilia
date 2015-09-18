class Task < ActiveRecord::Base


  belongs_to :admin

  scope :completed, -> { where("task_status = ?", true) }
  scope :active, -> { where("task_status = ?", false) }

  def title=(title)
    write_attribute(:title, title.strip)
  end	



end