class UsersController < ApplicationController




	before_action :authenticate_access












  def index

	get_users

  end





  def deactivated_user_index
  	get_deactivated_users
  end









  # GET /users/1/edit
  def edit

  	@user = User.find(params[:id])


  end









  # POST /users
  # POST /users.json
  def create
    @user = user.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end











  def update


  	if params[:user][:password].blank?
  		params[:user].delete(:password)
  		params[:user].delete(:password_confirmation)
  	end




    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end



  end

















  # completely destroy account
  def destroy
  	@user = User.find(params[:id])
    
    respond_to do |format|
      if (user_signed_in?) && (current_user.id == @user.id)
      	@user.destroy
        format.html { redirect_to users_url, notice: 'user has successfully destroyed their account.' }
      elsif admin_signed_in?
      	@user.destroy
        format.html { redirect_to users_url, notice: 'user was successfully destroyed by admin.' }
      end


      format.json { head :no_content }
    end
  end











  def deactivate
  	@user = User.find(params[:id])
    @user.create_activity action: :deactivate, owner: @current_app_usr
    respond_to do |format|
      if (user_signed_in?) && (current_user.id == @user.id)
      	@user.activation_status = false
      	@user.save
        format.html { redirect_to users_url, notice: 'user has successfully cancelled their account.' }
      elsif admin_signed_in?
      	@user.activation_status = false
      	@user.save
        format.html { redirect_to users_url, notice: 'user was successfully deactivated by admin.' }
      end
      format.json { head :no_content }
    end
  end












  def reactivate
  	@user = User.find(params[:id])
    @user.create_activity action: :reactivate, owner: @current_app_usr
    respond_to do |format|
      	@user.activation_status = true
      	@user.save
        format.html { redirect_to users_url, notice: 'user was successfully reactivated by admin.' }
        format.json { head :no_content }
      end
  end































private


	def get_users
		@users = User.where(type: "User", activation_status: true)
	end


	def get_deactivated_users
		@users = User.where(type: "User", activation_status: false)
	end



	# Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :activation_status)
    end













end







