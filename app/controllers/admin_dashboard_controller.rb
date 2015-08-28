class AdminDashboardController < ApplicationController

  layout 'adminlogin'


	# restrict access to admins only
	before_action :authenticate_admin



	before_action :set_ticket, only: [:show, :resolve, :update, :destroy]




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

  # GET /admin_dashboard/1/resolve
  def resolve
    # restrict resolve access to open tickets or appropriate admin
    unless @ticket.status == nil || current_admin.id == @ticket.admin_id
      redirect_to '/'
    end
  end



  # PATCH/PUT /admin_dashboard/1
  # PATCH/PUT /admin_dashboard/1.json
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

  # DELETE /admin_dashboard/1
  # DELETE /admin_dashboard/1.json
  def destroy
    # restrict destroy option to appropriate admin
    if current_admin.id == @ticket.admin_id
      @ticket.destroy
      respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
      end
    else
      redirect_to '/'
    end

  end








  def analytics
    get_tickets
    analyze_ticket_status
    analyze_yearly_ticket_activity
    analyze_categories
    #analyze_admins

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

























def analyze_ticket_status

  @closed_tally = @in_progress_tally = @open_tally = 0


  @tickets.each do |ticket| 
    case ticket.status
      when true
        @closed_tally += 1
      when false
        @in_progress_tally += 1
      else
        @open_tally += 1

    end



  end


  gon.status_data = [{
                    name: "Closed",
                    y: @closed_tally
                }, {
                    name: "In Progress",
                    y: @in_progress_tally

                }, {
                    name: "Open",
                    y: @open_tally
                }
                ]




end





















def analyze_yearly_ticket_activity



  gon.monthly_created_activity = []
  gon.monthly_closed_activity = []



  @monthly_created_activity = []
  @monthly_closed_activity = []

  



  # starting 1 year ago (12months ago)
  @date_index = (DateTime.now - 1.year)

  @month_index = 1


  while @month_index <= 12
    @monthly_created_tally = @monthly_closed_tally = 0




    @tickets.each do |ticket|
      if (ticket.status == true) && (ticket.created_at.month == @date_index.month)
         @monthly_created_tally += 1
      end
      if (ticket.status == true) && (ticket.closed_at.month == @date_index.month)
         @monthly_closed_tally += 1
      end
    end # end of ticket loop



    gon.monthly_created_activity << @monthly_created_tally
    gon.monthly_closed_activity << @monthly_closed_tally


    # increment indexes to iterate through 12 months of data
    @date_index = @date_index + 1.month 
    @month_index += 1


  end # end of while loop








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
      when 'HR'
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
  @other_pct = (@other_tally/@total_tally.to_f)*100



  gon.category_data = [{
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
                
                },{
                    name: "Other",
                    y: @other_pct
                  }]








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
