module Beholder
  module Commands
    module Neg

      extend Discordrb::Commands::CommandContainer
      command(:neg, usage: 'neg [user]', min_args: 1,
              description: 'Removes reputation from specified user.') do |event, amount, mention |

        @discord_user = event.bot.parse_mention(mention)

        if amount.to_i > 0
          return -(amount.to_i)
        end

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
            event << "You just negged for <@#{@discord_user.id}>, for **#{amount}** reputation!'"
        end
      end
      end
    end
  end
