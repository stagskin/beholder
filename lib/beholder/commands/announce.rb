module Beholder
  module Commands
    # Announces a message server-wide.
    module Announce
      extend Discordrb::Commands::CommandContainer
      command(:a, description: 'Announces your text server-wide.',
                         min_args: 1, required_permissions: [:manage_messages],
                         usage: 'announce <text>') do |event, *text|
        bot_profile = event.bot.profile.on(event.server)
        event.server.text_channels.each do |channel|
          next unless bot_profile.permission?(:send_messages, channel)
          channel.send_message("**#{event.author.username}**: #{text}")
        end
        nil
      end
    end
  end
end
