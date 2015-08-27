namespace :db do
  desc "Erase and Populate database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    

    password = 'password'


    [Ticket, User].each(&:delete_all)


    User.populate 500 do |user|
      user.email   = Faker::Internet.email
      user.encrypted_password = User.new(:password => password).encrypted_password


      Ticket.populate 0..4 do |ticket|
        ticket.user_id = user.id
        ticket.title = Populator.words(2..4).titleize
        ticket.description = Populator.sentences(2..20)
        ticket.solution = Populator.sentences(2..20)
        ticket.status = [nil, false, true]
        ticket.created_at = (2.years.ago..DateTime.now)



      
        random_update = rand(4)
        if ticket.status == nil && random_update == 1
            ticket.updated_at = ( (ticket.created_at+1.second)..DateTime.now)
        else
            ticket.updated_at = nil
        end


        if ticket.status == true
            ticket.closed_at = ( (ticket.created_at+1.second)..DateTime.now)
        end



        ticket.category = ['Software', 'Hardware', 'Maintenance', 'Billing', 'HR', 'Other']



        if ticket.status == false || ticket.status == true
          ticket.admin_id = 1..5
        end
      end

    end



  end
end