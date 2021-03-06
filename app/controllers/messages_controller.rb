class MessagesController < ApplicationController
  before_action :authenticate_access




  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end





  def create
    recipients = User.where(id: params['recipients'])

    conversation = @current_app_usr.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end




end