require 'rubygems'
require 'gtk2'
require 'test/unit'

require_relative '../Model/game.rb'
require_relative '../view/ui_game.rb'

class GameController
	include Test::Unit::Assertions

	def initialize()	  
	  	# -- Pre Conditions -- #

	  	# -- Code -- #
		if __FILE__ == $0

		  	# Initialize GTK stuff
		  	Gtk.init
		  	@builder = Gtk::Builder::new
		  	@builder.add_from_file("./C4Ruby.glade")
		  	@builder.connect_signals{ |handler| method(handler) }

		  	# Initialize models
			@game = Game.new

			@win = false

			# Initialize views and controllers
			@screen_index = -1 #change this to a stack - WHY A STACK?
			@screens = Array.new
			@controllers = Array.new

			view = View::UiGame.new(@builder, @game)
			push(view)
			controllers.add(Board.new(@builder, @game, view.board))

			Gtk.main()

			#play()
		end

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
		  push(Menu.new) # WHY? 1. This is a controller, not a view
		  				 #      2. This is an infinite stack of menus


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
	    assert(!self.is_a?(GameController))
		return self
	    # -- Post Conditions -- #
	end
end

