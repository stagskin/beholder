module Beholder
  module Commands
    module Level
      extend Discordrb::Commands::CommandContainer

      command(:l, description: "Displays current user's level") do |event|

        event << 'Your current level is:'
        event << "#{repository(:default).adapter.select("SELECT level FROM beholder_database_manager_properties WHERE id = #{event.author.id}")}"
      end

    end
  end
end