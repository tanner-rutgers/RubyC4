require_relative '../Model/game.rb'
require_relative '../view/*'

class GameController
	def initialize()	  
	  # -- Pre Conditions -- #

	  # -- Code -- #
		@game = Game.new
		@win = false
		@screen_index = -1 #change this to a stack
		@screens = Array.new

		play()

	  # -- Post Conditions -- #
		assert(!@game.nil?)
	end

	# infinite loop in which the game runs
	def play()
	  # -- Pre Conditions -- #
	  assert(!@game.board.nil?)


	  # -- Code -- #
	  continue = true;
	  while(continue)
		  push(Menu.new)


		#####MOARCODE
	  end
	  exit()

	  # -- Post Conditions -- #
	  assert(!@game.currentPlayersTurn.nil?)
	  assert(@game.players.include?(@currentPlayersTurn))
	  assert(!@game.currentPlayersTurn.nil?)
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

		#push next screen, update @screen_index
		@screen_index+=1
		@screens[@screen_index] = screen
	end

	def pop()
		assert(!screen.nil?)
		assert(screen.is_a?View)

		#pop current screen, decrement @screen_index
		@screens[@screen_index] = nil
	    @screen_index-=1
	end

	def get_controller()
	    # -- Pre Conditions -- #
	    assert(!self.is_a?GameController)
		return self
	    # -- Post Conditions -- #
	end
end

