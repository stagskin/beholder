require 'data_mapper'
require 'dm-aggregates'

module Beholder
  module Commands
    # Adds user to database.
    module Echo
      extend Discordrb::Commands::CommandContainer

      DataMapper.setup(:default, 'sqlite:///home/stag/Projects/Beholder/beholder/lib/data/users.db')

      command(:echo, description: 'Adds new user to database with deafult values.',
              usage: ';echo [user mention] /n Defaults to user when no mention is given.', help_availabe: true, max_args: 1) do |event, mention|

        @discord_user = event.bot.parse_mention(mention)
        if @discord_user != nil && DatabaseManager::Properties.count(:id => "<@#{@discord_user.id}>") < 1
          @user = DatabaseManager::Properties.first_or_create({:id => "<@#{@discord_user.id}>"},
                                                              {:id => "<@#{@discord_user.id}>",
                                                               :level => 1,
                                                               :experience => 0,
                                                               :reputation => 0,
                                                               :join_date => Time.now.getutc,
                                                               :active => TRUE
                                                              })
          @user.save
          event << "<@#{@discord_user.id}>"
          event << "You've been added to the database"
          event << "Your timestamp is #{Time.now.getutc}"
        elsif @discord_user != nil && DatabaseManager::Properties.count(:id => "<@#{@discord_user.id}>") == 1
          event << "<@#{@discord_user.id} is already in the Database!"
        elsif DatabaseManager::Properties.count(:id => "<@#{event.author.id}>") < 1
          @user = DatabaseManager::Properties.first_or_create({:id => "<@#{event.author.id}>"},
                                                              {:id => "<@#{event.author.id}>",
                                                               :level => 1,
                                                               :experience => 0,
                                                               :reputation => 0,
                                                               :join_date => Time.now.getutc,
                                                               :active => TRUE
                                                              })
          @user.save
          event << "<@#{event.author.id}>"
          event << "You've been added to the database"
          event << "Your timestamp is #{Time.now.getutc}"
        else
          event << "<@#{event.author.id}>"
          event << "You're already in the database! :smile:"
        end

      end
    end
  end
end
