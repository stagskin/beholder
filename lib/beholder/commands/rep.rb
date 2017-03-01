require 'data_mapper'
require 'dm-aggregates'
require 'dm-adjust'

module Beholder
  module Commands
    module Rep

      extend Discordrb::Commands::CommandContainer
      command(:rep, usage: ';rep [amount] [user]', max_args: 2,
              description: 'Adds reputation to specified user.') do |event, amount, mention |

        @discord_user = event.bot.parse_mention(mention)
        case @discord_user
          when nil
            event << "<@#{event.author.id}>"
            event << "Your current rep is :mega:"
            event << "```Markdown"
            event << "##{repository(:default).adapter.select("SELECT reputation FROM beholder_database_manager_properties WHERE id = #{event.author.id}")}"
            event << "```"
          when @discord_user == event.author.id
            event << "<@#{event.author.id}>"
            event << "Your current rep is :mega:"
            event << "```Markdown"
            event << "##{repository(:default).adapter.select("SELECT reputation FROM beholder_database_manager_properties WHERE id = #{event.author.id}")}"
            event << "```"
          else
            @user = DatabaseManager::Properties.all(:id => @discord_user.id)
            @start_rep = repository(:default).adapter.select(
                "SELECT reputation FROM beholder_database_manager_properties WHERE id = #{@discord_user.id}").join.to_i
            @end_rep = (amount.to_i) + @start_rep
            @user.update(:reputation => @end_rep.to_i)
            @user.save
            event << "<@#{event.author.id}>"
            event << "You just added **#{amount}**, to <@#{@discord_user.id}>'s reputation!'"
        end

      end
    end
  end
end