module Beholder
  module Events
    # Adds one to messages read stat every time a new message is received.
    module MessagesReadStat
      extend Discordrb::EventContainer
      message(starting_with: not!(CONFIG.prefix),
              private: false) do |event|
        STATS.messages_read += 1 unless event.author.current_bot?
      end
    end
  end
end
