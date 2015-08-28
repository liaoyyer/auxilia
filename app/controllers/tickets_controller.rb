class TicketsController < ApplicationController



  layout 'userlogin'





  # restrict access to users and admins only
  before_action :authenticate_access

  before_action :set_ticket, only: [:show, :edit, :update, :destroy]



  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
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
    # restrict edit access to the creator of the ticket
    unless current_user.id == @ticket.user_id
      redirect_to '/'
    end

  end









  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
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
      if user_signed_in? 
        format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed by user.' }
      elsif admin_signed_in?
        format.html { redirect_to admin_dashboard_url, notice: 'Ticket was successfully destroyed by admin.' }
      end


      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :category, :user_id, :admin_id, :status, :solution)
    end









end
