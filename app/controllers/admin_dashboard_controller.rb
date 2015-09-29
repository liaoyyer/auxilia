class AdminDashboardController < ApplicationController




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
  # for resolve page
  def resolve
    # restrict resolve access to open tickets or appropriate admin
    unless @ticket.status == nil || current_admin.id == @ticket.admin_id
      redirect_to '/'
    end
  end




  # PATCH/PUT /admin_dashboard/1
  # PATCH/PUT /admin_dashboard/1.json
  # action triggered by resolve button on resolve page
  def update



    @ticket.admin_id = current_admin.id 
    respond_to do |format|
      if @ticket.update(ticket_params)


        # twilio code goes here


        format.html { redirect_to show_admin_path, notice: 'Ticket was successfully updated by admin.' }
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
      format.html { redirect_to '/', notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
      end
    else
      redirect_to '/'
    end

  end








  def metrics
    get_tickets

    # redirect if there are no tickets to analyze
    if @tickets.empty?
      redirect_to '/'
    end


    get_ticket_data
    analyze_ticket_status
    analyze_yearly_ticket_activity
    analyze_categories
    analyze_admins

  end











def activity

  get_activities


end









def admin_user_management

  get_admins

end




















	private











  def get_activities

    @all_activities = PublicActivity::Activity.order('created_at DESC')

  end













	# Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :category, :status, :solution, :initial_response_time)
    end


	def get_tickets
		@tickets = Ticket.all
  end







  def get_admins
    @admins = Admin.all
  end




















def analyze_ticket_status

  @resolved_tally = @in_progress_tally = @open_tally = 0


  @tickets.each do |ticket| 
    case ticket.status
      when true
        @resolved_tally += 1
      when false
        @in_progress_tally += 1
      else
        @open_tally += 1

    end



  end


  gon.status_data = [{
                    name: "Resolved",
                    y: @resolved_tally
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

  require 'date'

  gon.monthly_created_activity = []
  gon.monthly_resolved_activity = []



  @monthly_created_activity = []
  @monthly_resolved_activity = []

  



 #collect data on the past 12 months up to the last completed month
  @date_index = (DateTime.now - 12.months)
  gon.month_interval = []







  @month_index = 1
  while @month_index <= 12
    @monthly_created_tally = @monthly_resolved_tally = 0


    gon.month_interval << DateTime::ABBR_MONTHNAMES[@date_index.month]

    @tickets.each do |ticket|
      if (ticket.created_at.month == @date_index.month) && (ticket.created_at.year == @date_index.year)
         @monthly_created_tally += 1
      end

      if (ticket.status == true) && (ticket.updated_at.month == @date_index.month) && (ticket.updated_at.year == @date_index.year)
         @monthly_resolved_tally += 1
      end
    end # end of ticket loop



    gon.monthly_created_activity << @monthly_created_tally
    gon.monthly_resolved_activity << @monthly_resolved_tally


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
















def get_ticket_data


  gon.total_tickets = Ticket.count
  gon.resolved_tickets = Ticket.where(status: true).count
  gon.in_progress_tickets = Ticket.where(status: false).count




  # unless there are no resolved tickets to analyze, do calculations
  unless gon.resolved_tickets == 0
    @total_resolution_time = 0
    @tickets.each do |ticket| 
      if(ticket.status == true)
        @total_resolution_time = @total_resolution_time + (ticket.updated_at - ticket.created_at)
      end
    end
    gon.avg_resolution_time = "%.2f hrs" % ( (@total_resolution_time / gon.resolved_tickets) / 3600)
  end



  # unless responses have yet to be made, do calculations
  unless gon.resolved_tickets == 0 && gon.in_progress_tickets == 0
    @total_initial_response_time = 0
    gon.avg_initial_response_time = 0


    @tickets.each do |ticket| 
    
      if(ticket.status == true || ticket.status == false)
        @total_initial_response_time = @total_initial_response_time + (ticket.initial_response_time - ticket.created_at)
      end

    end



    gon.avg_initial_response_time = "%.2f hrs" % ( (@total_initial_response_time / (gon.resolved_tickets + gon.in_progress_tickets) / 3600) )


  end






end











def analyze_admins



  # query = "SELECT admin_id, COUNT(*) FROM tickets WHERE status = true GROUP BY admin_id;"





  gon.admins = Array.new
  gon.admin_counts = Array.new



  @admin_performance = @tickets.where(status: true).order(admin_id: :asc).group(:admin_id).count


  @admin_performance.each do |admin_id, count| 
    gon.admins << admin_id
    gon.admin_counts << count
  end







  # for each admin calulate the average resolution time
  @total_admin_resolution_time = DateTime.new
  @avg_admin_resolution_times = Array.new
  

  @admin_performance.each do |admin_id, count| 
    @total_admin_resolution_time = 0 
    @tickets.each do |ticket|
      if ticket.admin_id == admin_id && ticket.status == true
        @total_admin_resolution_time = @total_admin_resolution_time + (ticket.updated_at - ticket.created_at)
      end      
    end
    @avg_admin_resolution_times << ((@total_admin_resolution_time / count) / 3600).round(2)
  end



  gon.avg_admin_resolution_times = @avg_admin_resolution_times


end










































end
