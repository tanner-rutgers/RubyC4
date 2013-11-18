require_relative 'observable.rb'

class GameController
	include Observable
	
	def initialize()
	  
	  # -- Pre Conditions -- #

	  # -- Code -- #
		@game = Game.new
		@win = false

		play()

	  # -- Post Conditions -- #
		assert(!@game.nil?)
		assert(win.false?)
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
	    # -- Pre Conditions -- #
	    assert(!self.is_a?GameController)
		return self
	end
end

