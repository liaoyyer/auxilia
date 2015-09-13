class Ticket < ActiveRecord::Base

	belongs_to :user
	belongs_to :admin




	include PublicActivity::Model

	tracked owner: Proc.new {|controller, model| controller.current_user ? controller.current_user : controller.current_admin}








end



