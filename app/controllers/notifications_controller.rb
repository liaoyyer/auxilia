class NotificationsController < ApplicationController


  skip_before_action :verify_authenticity_token

  def notify
  	client = Twilio::REST::Client.new 
  	message = client.messages.create from: '13307541274', to: '17027384831', body: 'Learning to send SMS you are.'



  	render plain: message.status




  end







end