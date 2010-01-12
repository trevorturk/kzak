pass = ActiveSupport::SecureRandom.hex(20)
User.create!(:login => 'admin', :email => CONFIG['mailer'], :password => pass, :password_confirmation => pass)
puts "...created 'admin' user with password '#{pass}'"