namespace :db do
  desc "Erase and Populate database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    

    password = 'password'


    [Ticket, User, Admin, ToDo].each(&:delete_all)

    ["mailboxer_receipts", "mailboxer_notifications", "mailboxer_conversations", "mailboxer_conversation_opt_outs", "activities"].each do |table|
      sql = "DELETE FROM #{table};"
      ActiveRecord::Base.connection.execute(sql)
    end




    Admin.populate 5 do |admin|
      admin.firstname = Faker::Name.first_name
      admin.lastname = Faker::Name.last_name
      admin.email   = Faker::Internet.email
      admin.encrypted_password = Admin.new(:password => password).encrypted_password


      ToDo.populate  0..11 do |todo|
        todo.admin_id = admin.id
        todo.title = Populator.words(2..4).titleize
        todo.notes = Populator.sentences(0..10)
        todo.due_date = (DateTime.now+1.hour)..(DateTime.now+2.months)
      end


    end




    






    admin_ids = Array.new
    admin_ids = Admin.pluck(:id)


    User.populate 500 do |user|
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email   = Faker::Internet.email
      user.encrypted_password = User.new(:password => password).encrypted_password


      Ticket.populate 0..4 do |ticket|
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







          # if the ticket is in progress or closed, assign an admin and response time
          if ticket.status == false || ticket.status == true
            ticket.admin_id = admin_ids.sample
            ticket.initial_response_time = (ticket.created_at..ticket.updated_at)
          end










      end

    end
























  end
end