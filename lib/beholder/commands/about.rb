module Beholder
  module Commands
    # Prints most useful information about the bot.
    module About
      extend Discordrb::Commands::CommandContainer
      command(:about, description: 'Shows information about this bot.') do |event|
        event << "#{event.author.username}"
        event << "Owner: <@#{CONFIG.owner_id}>."
        event << "Version: #{VERSION}."
      end
    end
  end
end
