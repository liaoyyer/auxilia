namespace :db do
  desc "Erase and Populate database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    

    password = 'password'


    [Ticket, User].each(&:delete_all)


    User.populate 5 do |user|
      user.email   = Faker::Internet.email
      user.encrypted_password = User.new(:password => password).encrypted_password


      Ticket.populate 0..2 do |ticket|
        ticket.user_id = user.id
        ticket.title = Populator.words(2..4).titleize
        ticket.description = Populator.sentences(2..20)
        ticket.category = ['Software', 'Hardware', 'Maintenance', 'Billing', 'HR', 'Other']
        ticket.status = [nil, false, true]
        ticket.created_at = (2.years.ago..DateTime.now)



        if ticket.status == nil
            ticket.updated_at = nil
        end

        random_update = rand(4)
        if ticket.status == nil && random_update == 1
            ticket.updated_at = ( (ticket.created_at+1.second)..DateTime.now)
        elsif ticket.status == false
            ticket.updated_at = ( (ticket.created_at+1.second)..DateTime.now)
        elsif ticket.status == true
            ticket.solution = Populator.sentences(2..20)
            ticket.updated_at = ( (ticket.created_at+1.second)..DateTime.now)
        end






        if ticket.status == false || ticket.status == true
          ticket.admin_id = 1..5
          ticket.initial_response_time = (ticket.created_at..ticket.updated_at)
        end







      end

    end



  end
end