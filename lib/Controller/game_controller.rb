Class GameController
	def initialize()	  
	  # -- Pre Conditions -- #

	  # -- Code -- #
		@game = Game.new
		@win = false
		@current_screen = nil;
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
	  # -- Pre Conditions -- #
	  assert(!@win.nil?)
	  return @win

	  # -- Post Conditions -- #
	end

	def push(screen)
		assert(!screen.nil?)
		assert(screen.is_a?View)
		#push next screen, update @current_screen
		
	end

	def get_controller()
	    # -- Pre Conditions -- #
	    assert(!self.is_a?GameController)
		return self
	    # -- Post Conditions -- #
	end
end

