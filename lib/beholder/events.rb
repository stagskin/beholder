module Beholder
  # Module for sapphire events.
  module Events
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/events/*.rb"].each { |file| require file }

    @events = [
      Mention,
      MessagesReadStat,
      ReadyMessage
    ]

    def self.include!
      @events.each do |event|
        Beholder::BOT.include!(event)
      end
    end
  end
end
