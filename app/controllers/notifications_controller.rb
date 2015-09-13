class NotificationsController < ApplicationController


  skip_before_action :verify_authenticity_token

  def notify
  	client = Twilio::REST::Client.new '', ''
  	message = client.messages.create from: '', to: '', body: 'Your ticket has been resolved.'


  	# return some plain text with the status of the sent text message
  	render plain: message.status



  end







end