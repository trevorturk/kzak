pass = ActiveSupport::SecureRandom.hex(8)
User.create!(:login => 'admin', :email => CONFIG['mailer'], :password => pass, :password_confirmation => pass)
puts "...created 'admin' user with password '#{pass}'"