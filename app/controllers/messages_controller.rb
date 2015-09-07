class MessagesController < ApplicationController
  before_action :authenticate_access
  before_action :set_roletype

  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end





  def create
    recipients = User.where(id: params['recipients'])

    conversation = @roletype.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end



  
end