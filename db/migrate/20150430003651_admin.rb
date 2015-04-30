class Admin < ActiveRecord::Migration
 def up
    admin = User.new
   
    admin.username = "admin@example.com"
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.role = "admin"
    admin.active = true
    admin.save!
  end

  def down
    admin = User.find_by_username "admin@example.com"
    User.delete admin
  end 
end
