module Beholder
  # Module for sapphire commands.
  module Commands
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }

    @commands = [
      Announce,
      Delete,
      Flip,
      Invite,
      Lmgtfy,
      Roll,
      Stats,
      Ping,
      KickAll,
      About,
      Avatar,
      Eval,
      Toggle,
      Set,
      Default,
      Settings,
      Ignore,
      Join,
      Leave,
    ]

    def self.include!
      @commands.each do |command|
        Beholder::BOT.include!(command)
      end
    end
  end
end
