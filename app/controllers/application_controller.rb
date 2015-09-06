class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end


  before_action :configure_permitted_parameters, if: :devise_controller?


  def redirect_back_or(path)
    redirect_to request.referer || path
  end





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



def redirect_back_or(path)
  redirect_to request.referer || path
end




  def set_roletype
    if user_signed_in?
      @roletype = current_user
    elsif admin_signed_in? 
      @roletype = current_admin
    end
  end





  def set_type

    

  end








  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:sign_up) <<:lastname
    devise_parameter_sanitizer.for(:account_update) << :firstname
    devise_parameter_sanitizer.for(:account_update) << :lastname
  end












end
