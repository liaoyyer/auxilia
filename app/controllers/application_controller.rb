class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # After devise sign in
  def after_sign_in_path_for(resource)
  	if resource.class == User
  			tickets_path
  	elsif resource.class == Admin
  			admin_dashboard_path
  	end
  end




  def adminfilter
    if admin_signed_in?
      redirect_to admin_dashboard_path
    end
  end



  def userfilter
    if user_signed_in?
      redirect_to '/'
    end
  end


  def authenticate_access
  	unless admin_signed_in? || user_signed_in?
  		redirect_to '/'
  	end
  end






end
