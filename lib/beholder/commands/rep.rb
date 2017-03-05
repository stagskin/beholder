require 'data_mapper'
require 'dm-aggregates'
require 'dm-adjust'

module Beholder
  module Commands
    module Rep

      extend Discordrb::Commands::CommandContainer
      command(:r, usage: ';r [amount] [user]', max_args: 2,
              description: 'Adds reputation to specified user.') do |event, amount, mention |

        @discord_user = event.bot.parse_mention(mention)
        case @discord_user
          when nil
            event.message.delete
            event << "<@#{event.author.id}>"
            event << "Your current rep is :mega:"
            event << "```Markdown"
            event << "##{repository(:default).adapter.select("SELECT reputation FROM beholder_database_manager_properties WHERE id = #{event.author.id}")}"
            event << "```"
          when @discord_user == event.author.id
            event.message.delete
            event << "<@#{event.author.id}>"
            event << "Your current rep is :mega:"
            event << "```Markdown"
            event << "##{repository(:default).adapter.select("SELECT reputation FROM beholder_database_manager_properties WHERE id = #{event.author.id}")}"
            event << "```"
          else
            event.message.delete
            event.from_bot?
            @user = DatabaseManager::Properties.all(:id => @discord_user.id)
            @start_rep = repository(:default).adapter.select(
                "SELECT reputation FROM beholder_database_manager_properties WHERE id = #{@discord_user.id}").join.to_i
            @end_rep = (amount.to_i) + @start_rep
            @user.update(:reputation => @end_rep.to_i)
            @user.save
            if amount.to_i > 0
              event << "<@#{event.author.id}>"
              event << "You just added **#{amount}**, to <@#{@discord_user.id}>'s reputation!"
            elsif amount.to_i < 0
              event << "<@#{event.author.id}>"
              event << "WHOA! You just negged <@#{@discord_user.id}> for **#{amount}** reputation!"
            end

        end

      end
    end
  end
end