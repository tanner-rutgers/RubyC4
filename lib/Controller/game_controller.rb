Class GameController
	def initialize()
		@game = Game.new
	
		play()
	end

	def play()
		  # -- Pre Conditions -- #
		  assert(!@game.board.nil?)


		  # -- Code -- #

		  # -- Post Conditions -- #
		  assert(!@game.currentPlayersTurn.nil?)
		  assert(@game.players.include?(@currentPlayersTurn))
		end

	def win?()
		return @win
	end

	def push()
		#push next screen, update @current_screen
	end

	def get_controller()
		return self
	end
end

