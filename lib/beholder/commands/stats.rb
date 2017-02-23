module Beholder
  module Commands
    # Prints bot statistics.
    module Stats
      extend Discordrb::Commands::CommandContainer
      command(:stats, description: 'Shows bot statistics') do |event|
        ping = ((Time.now - event.timestamp) * 1000).to_i
        event << "\nServers: #{STATS.servers}."
        event << "Users: #{STATS.users}."
        event << "Times mentioned: #{STATS.mentions}."
        event << "Uptime: #{time_in_words(STATS.uptime)}."
        event << "Messages read: #{STATS.messages_read}."
        event << "Ping: #{ping}ms."
      end
    end
  end
end
