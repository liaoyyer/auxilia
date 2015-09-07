module MessagesHelper




  def recipients_options(chosen_recipient = nil)
    s = ''
    User.all.each do |user|




      if (user_signed_in? && user.id != current_user.id) || (admin_signed_in? && user.id != current_admin.id)
      	s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}' #{'selected' if user == chosen_recipient}>#{user.firstname}</option>"
      end

   
    end

    s.html_safe
  end










end