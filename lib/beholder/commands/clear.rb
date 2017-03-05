module Beholder
  module Commands
    # Deletes specified ammount of messages from the channel.
    module Clear
      extend Discordrb::Commands::CommandContainer
      command(:cls, description: 'Deletes messages in this channel.',
                       min_args: 1, required_permissions: [:manage_messages],
                       usage: ';cls <ammount>') do |event, ammount|
        if event.bot.profile.on(event.server).permission?(:manage_messages,
                                                          event.channel)
          ammount = ammount.to_i
          next "Can't delete less than 2 messages." if ammount < 2

          while ammount > 100
            event.channel.prune(100)
            ammount -= 100
          end
          event.channel.prune(ammount) if ammount >= 2
          nil
        end
        event.message.delete
      end
    end
  end
end
