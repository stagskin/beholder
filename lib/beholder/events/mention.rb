module Beholder
  module Events
    # Responds on mention.
    module Mention
      extend Discordrb::EventContainer
      mention do |event|
        event.respond("**Beholder Bot** Rev#{VERSION} live and ready!")
        if event.channel.id == 287766198123233280
          event << '```Markdown'
          event <<  StatBoard.post_user_stats
          event << '```'
        end
        STATS.mentions += 1
      end
    end
  end
end
