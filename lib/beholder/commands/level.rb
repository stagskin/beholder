module Beholder
  module Commands
    module Level
      extend Discordrb::Commands::CommandContainer

      command(:l, description: "Displays current user's level") do |event|

        event << "<@#{event.author.id}>"
        event << '***Your current level is:***'
        event << '```Markdown'
        event << "#{repository(:default).adapter.select("SELECT level FROM beholder_database_manager_properties WHERE id = #{event.author.id}").join}"
        event << '```'
      end

    end
  end
end