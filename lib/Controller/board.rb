require 'test/unit'

require_relative 'observable.rb'
require_relative '../Model/player.rb'
require_relative '../Model/game.rb'
require_relative '../view/ui_board.rb'


module Controller

  class Board
	  include Test::Unit::Assertions
	  include Observable

	  def initialize(builder, gameModel, boardView, player)
		  #Preconditions
		  assert(builder.is_a?Gtk::Builder)
		  assert(gameModel.is_a?Model::Game)
		  assert(boardView.is_a?View::UiBoard)
		  assert(player.is_a?Model::Player)

		  @builder = builder
		  @gameModel = gameModel
		  @boardView = boardView
		  @player = player
		  setupHandlers

		  #Postconditions
		  assert_equal(@builder, builder)
		  assert_equal(@gameModel, gameModel)
		  assert_equal(@boardView, boardView)
		  assert_equal(@player, player)
	  end

	  def setupHandlers

		  @gameModel.board.size[:columns].times { |i|
			  @builder.get_object("columnButton" + i.to_s).signal_connect("clicked") { dropButtonClicked(i) }
		  }
	  end

	  def dropButtonClicked(column)
            
      
		  begin 
			  @gameModel.makeMove(@player, column)
        @gameModel.makeMove(@gameModel.players[1], column)
		  rescue Model::Board::ColumnFullException
			  puts "column full"
		  rescue Model::Game::NotYourTurnException
			  puts "not your turn"
		  end

		  @boardView.update
	  end
    
  end
end
