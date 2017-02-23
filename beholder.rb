require 'discordrb'

$bot = Discordrb::Bot.new token: 'MjQ5NzIyNjkxOTI4NDU3MjE3.Cy8qCw.12zuWfjQX0N-UbS2Q8qbWwMNV4c',  client_id: 249722691928457217

$bot.name= 'Beholder'

module COMMAND_HANDLER


	#Command Array

	@COMMANDS = %w(init
								greet
								rep
								neg
								help
								setplay)
	def handle_command(command)
		@command = command


		case @command

			#This command will test to ensure the command handler is functioning by sending a short
			#initialization message within the channel the command was executed in. This is done by
			#ensuring the command is called, then sending the message in the same channel.

			when 'init'.split('!')

				$bot.mention(256551588108304385)
				$bot.send_message(256551588108304385,
				                  "Command Handler is functional. #{$bot.name} initialized.")

		end
	end

	def initialize
	end

end


$bot.run :async

loop do
	until _command = $bot.message
	 _command.start_with?('!')
		handle_command(_command.split('!'))
	end



end