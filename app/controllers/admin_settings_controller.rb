class AdminSettingsController < ApplicationController


	before_action :authenticate_admin




	before_action :set_admin, only: [:show, :edit, :update, :destroy]











  def index

	set_admin

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










  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
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

















  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      if admin_signed_in? 
        format.html { redirect_to admins_url, notice: 'admin has successfully cancelled their account.' }
      elsif admin_signed_in?
        format.html { redirect_to admins_url, notice: 'admin was successfully deleted by admin.' }
      end


      format.json { head :no_content }
    end
  end








































	private


	# Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(current_admin.id)
    end





    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:firstname, :lastname, :email)
    end







































end
