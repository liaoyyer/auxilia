module MessagesHelper




  def recipients_options(chosen_recipient = nil)
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}' #{'selected' if user == chosen_recipient}>#{user.firstname}</option>"
    end


    Admin.all.each do |admin|
      s << "<option value='#{admin.id}' data-img-src='#{gravatar_image_url(admin.email, size: 50)}' #{'selected' if admin == chosen_recipient}>#{admin.firstname}</option>"
    end

    s.html_safe
  end










end