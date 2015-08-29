class Ticket < ActiveRecord::Base

	belongs_to :user
	belongs_to :admin



	self.record_timestamps = false



end
