require 'rubygems'
require 'gtk2'
require 'test/unit'

require_relative '../Model/game.rb'
require_relative '../view/ui_game.rb'
require_relative 'board.rb'
require_relative 'colour.rb'
require_relative 'ai.rb'
require_relative 'file_menu.rb'

class GameController
	include Test::Unit::Assertions

	def initialize(game)	  
	  	# -- Pre Conditions -- #
		assert(game.is_a?Model::Game)

	    # -- Code -- #
	    Gtk.init
        @builder = Gtk::Builder::new
        @builder.add_from_file(File.expand_path("../../C4Ruby.glade", File.dirname(__FILE__)))

        @gameModel = Model::Game.new()

        game = View::UiGame.new(@builder, @gameModel)

        boardController = Controller::Board.new(@builder, @gameModel, @gameModel.players[0])
        boardController.addObserver(game.get_view(View::UiBoard)) 
        boardController.addObserver(game.get_view(View::UiStatusInfo))

        aiController = Controller::AI.new(@builder, @gameModel.players[0], @gameModel.players[1], @gameModel)
        aiController.addObserver(game.get_view(View::UiBoard))
        aiController.addObserver(game.get_view(View::UiStatusInfo))
         
        #When someone makes a move it will notify the AI controller it needs to make the next move.
        boardController.addObserver(aiController)

        colourController = Controller::Colour.new(@builder, @gameModel.players[0], @gameModel.players[1])
        colourController.addObserver(game.get_view(View::UiBoard))

        fileMenuController = Controller::FileMenu.new(@builder, @gameModel)
        fileMenuController.addObserver(game.get_view(View::UiBoard))
        fileMenuController.addObserver(game.get_view(View::UiStatusInfo))

        game.show

		# -- Post Conditions -- #
	end

end

