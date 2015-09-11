class ApplicationController < ActionController::Base
  include PublicActivity::StoreController 


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  layout :layout_by_resource

  before_action :set_app_usr
  before_action :get_mailbox

  before_action :load_activity_info, if: :admin_signed_in?



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




  def authenticate_admin
      if !(admin_signed_in?)
          redirect_to new_admin_session_path
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




  def set_app_usr
    if user_signed_in?
      @current_app_usr = current_user
    elsif admin_signed_in? 
      @current_app_usr = current_admin
    end
  end




  def get_mailbox
    if user_signed_in? || admin_signed_in?
      @mailbox ||= @current_app_usr.mailbox
    end
  end


  def load_activity_info
    @recent_activities = PublicActivity::Activity.order('created_at DESC').limit(5)
    @activity_count = PublicActivity::Activity.count
  end








  protected



def layout_by_resource
  if devise_controller? && resource_name == :user
    'userlogin'
  elsif devise_controller? && resource_name == :admin 
    'adminlogin'
  else
    'application'
  end
end











  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:sign_up) <<:lastname
    devise_parameter_sanitizer.for(:account_update) << :firstname
    devise_parameter_sanitizer.for(:account_update) << :lastname
  end







end
