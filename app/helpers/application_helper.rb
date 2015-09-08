module ApplicationHelper

# mailboxer helper 
def page_header(text)
  content_for(:page_header) { text.to_s }
end


def gravatar_for(user, size = 30, title = user.firstname)
  image_tag gravatar_image_url(user.email, size: size), title: title, class: 'img-rounded'
end



  def get_mailbox
    @mailbox ||= @current_app_usr.mailbox
  end

end
