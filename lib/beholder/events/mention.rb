module Beholder
  module Events
    # Responds on mention.
    module Mention
      extend Discordrb::EventContainer
      mention do |event|
        event.respond("**Beholder Bot** Rev#{VERSION} live and ready!")
        STATS.mentions += 1
      end
    end
  end
end
