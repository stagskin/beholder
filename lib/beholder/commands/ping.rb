module Beholder
  module Commands
    # Responds with response time.
    module Ping
      extend Discordrb::Commands::CommandContainer
      command(:p, description: 'Responds with response time.') do |event|
        "#{((Time.now - event.timestamp) * 1000).to_i}ms."
      end
    end
  end
end
