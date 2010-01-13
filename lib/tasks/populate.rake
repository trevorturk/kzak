namespace :db do
  task :populate => :environment do
    require 'populator'
    require 'faker'
    require File.expand_path(File.dirname(__FILE__) + "/../../test/blueprints")

    Rake::Task['db:schema:load'].invoke

    def random(model)
      ids = ActiveRecord::Base.connection.select_all("SELECT id FROM #{model.to_s.tableize}")
      model.find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
    end

    puts 'creating users...'
    User.make(:login => 'test', :email => 'test@example.com', :password => 'test')
    20.times { |i|
      User.make
    }

    puts 'creating posts...'
    100.times { |i|
      Post.make(:user => random(User))
    }

    puts 'creating followings...'
    20.times { |i|
      random(User).follow(random(User))
    }

  end
end