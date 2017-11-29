class AdminMailer < ApplicationMailer
   default from: 'enrollmeberkeley@gmail.com'
   
   def invite_new_admin(admin)
      @admin = admin
      @url = ENV["SERVER_EMAIL"]
      mail(to: @admin.email, subject: "Superadmin gave you access as admin for EnrollMe") do |format|
         format.html
      end
   end
   
   def team_list_email(admin, status)
      @admin = admin
      @url  = 'http://www.gmail.com'
      puts "!!!!!"
      puts status
      puts "!!!!!"
      mail(to: @admin.email, subject: 'Here is list of ' + status + ' teams in EnrollMe') do |format|
         puts "hello"
         @status = status
         puts "hello1"
         format.html
      end
   end

   def email_team_members(team, message)
      @team = team
      @team.users.each do |disapproved_user|
         @user = disapproved_user
         @url = ENV["SERVER_EMAIL"]
         mail(to: @user.email, subject: message) do |format|
            format.html
         end
      end
   end

   def send_approved_email(team)
      email_team_members(team, 'Your team has been approved')
   end
   
   def send_disapproved_email(team)
      email_team_members(team, 'Your team has been disapproved')
   end
   
   def look_at_submission(email)
      mail(to: email, subject: "Teams are awaiting your approval!")
   end
   
   def all_data(admin)
      @admin = admin
      mail(to: @admin.email, subject: 'Reset Semester: All data that was deleted') do |format|
        format.html
      end
   end
   
   def self.send_look_at_submission
      if !(Team.where("approved = ? AND submitted = ?", false, true).nil?)
         Admin.all.each do |admin|
            look_at_submission(admin.email).deliver
         end
      end
   end
end