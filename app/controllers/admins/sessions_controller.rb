class Admins::SessionsController < Devise::SessionsController

  # keep signed-in users from trying to sign in as admins
  # a user cannot login as an admin while they're still logged in as a user
  before_action :userfilter


# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end








end
