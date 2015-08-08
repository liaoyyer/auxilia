class AdminDashboardController < ApplicationController
	before_action :userfilter
	before_action :authenticate_admin

	layout "admin_layout"


	def index
		get_tickets
	end







	private

		def get_tickets
			@tickets = Ticket.all
		end


		# if signed in as user and trying to gain admin access, redirect to root
		# else if not signed in as admin or user redirect to admin login
		# (else if signed in as admin properly then allow access to admin_dashboard)
		def authenticate_admin
      		if !(admin_signed_in?)
        		redirect_to new_admin_session_path
        	end
      	end





end
