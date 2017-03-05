module Beholder
  # Module for sapphire commands.
  module Commands
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }

    @commands = [
      Announce,
      Clear,
      Flip,
      Roll,
      Stats,
      Echo,
      Rep,
      Ping,
      About,
      Avatar,
      Eval,
      Settings,
      Ignore,
    ]

    def self.include!
      @commands.each do |command|
        Beholder::BOT.include!(command)
      end
    end
  end
end
