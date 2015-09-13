class NotificationsController < ApplicationController


  skip_before_action :verify_authenticity_token

  def notify
  	client = Twilio::REST::Client.new 'ACa11ba8b0a7ab6158219c8b4251662d07', '9f1ae9b5ecd0f09ed2760ad9fc446d25'
  	message = client.messages.create from: '13307541274', to: '17027384831', body: 'Your ticket has been resolved.'


  	# return some plain text with the status of the sent text message
  	render plain: message.status



  end







end