class AdminSettingsController < ApplicationController

# controller for admin to manipulate their own personal settings
# this also functions as a way for authorizing only the current admin to maniplate their own settings
#   through this controller

	#admins only
	before_action :authenticate_admin

	before_action :set_admin











  def index



  end






  def edit




  end








  def create
    @admin = admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end









  def update


  	if params[:admin][:password].blank?
  		params[:admin].delete(:password)
  		params[:admin].delete(:password_confirmation)
  	end




    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_setting_path, notice: 'admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end



  end















  def destroy

    respond_to do |format|
      if @admin.id == current_admin
      	@admin.destroy 
        format.html { redirect_to admins_url, notice: 'admin has successfully cancelled their account.' }
      else
      	@admin.destroy
        format.html { redirect_to admins_url, notice: "admin was successfully deleted by admin# #{current.admin}." }
      end


      format.json { head :no_content }
    end
  end








































	private


	# this is what functions as a form of self-authorization
    def set_admin
      @admin = Admin.find(current_admin.id)
    end





    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:firstname, :lastname, :email)
    end







































end
