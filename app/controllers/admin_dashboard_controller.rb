class AdminDashboardController < ApplicationController


	# before_action :userfilter
	before_action :authenticate_admin



	before_action :set_ticket, only: [:show, :edit, :update, :destroy]




	def index
		get_tickets
	end



  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end



  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end







  # GET /tickets/new
  def analytics
    get_tickets
    analyze_categories
  end













	private



	# Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :category, :status, :solution)
    end


	def get_tickets
		@tickets = Ticket.all
	end

























def analyze_categories

  @software_tally = @hardware_tally = @billing_tally = @maintenance_tally = @hr_tally = @other_tally = 0


  @tickets.each do |ticket| 
    case ticket.category
      when 'Software'
        @software_tally += 1
      when 'Hardware'
        @hardware_tally += 1
      when 'Maintenance'
        @maintenance_tally += 1
      when 'Billing'
        @billing_tally += 1
      when 'Human Resources'
        @hr_tally += 1
      else
        @other_tally += 1
    end
  end


  @total_tally = @software_tally + @hardware_tally + @billing_tally + @maintenance_tally + @hr_tally + @other_tally





  @software_pct = (@software_tally/@total_tally.to_f)*100
  @hardware_pct = (@hardware_tally/@total_tally.to_f)*100
  @billing_pct = (@billing_tally/@total_tally.to_f)*100
  @maintenance_pct = (@maintenance_tally/@total_tally.to_f)*100
  @hr_pct = (@hr_tally/@total_tally.to_f)*100



@category_data = [{
                    name: "Software",
                    y: @software_pct
                }, {
                    name: "Hardware",
                    y: @hardware_pct

                }, {
                    name: "Maintenance",
                    y: @maintenance_pct
                }, {
                    name: "Billing",
                    y: @billing_pct
                }, {
                    name: "HR",
                    y: @hr_pct
                
                }]







  gon.category_data = @category_data




end


























def tally_status

  @closed_tally = @in_progress_tally = @open_tally = 0


  @tickets.each do |ticket| 
    case ticket.status
      when true
        @closed_tally += 1
      when false
        @hin_progress_tally += 1
      else
        @open_tally += 1
    end
  end





end










def admin_response_data

  # admin response data



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
