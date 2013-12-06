require 'test/unit'

require_relative 'observable.rb'
require_relative '../Model/player.rb'
require_relative '../Model/game.rb'
require_relative '../view/ui_board.rb'


module Controller

  class Board
    include Test::Unit::Assertions
    include Controller::Observable

    def initialize(builder, gameModel, player)
      #Preconditions
      assert(builder.is_a?Gtk::Builder)
      assert(gameModel.is_a?Model::Game)
      assert(player.is_a?Model::Player)

      @buttonLock = false
      
      @builder = builder
      @gameModel = gameModel
      @player = player
      setupHandlers

      #Postconditions
      assert_equal(@builder, builder)
      assert_equal(@gameModel, gameModel)
      assert_equal(@player, player)
    end

    def setupHandlers
      @gameModel.board.size[:columns].times { |i|
	      @builder.get_object("columnButton" + i.to_s).signal_connect("clicked") { dropButtonClicked(i) }
      }
    end

    def dropButtonClicked(column)
      
      begin 
	@buttonLock = true
	
	if(@gameModel.respond_to?("pseudoMakeMove"))
	  @gameModel.pseudoMakeMove(@player, column)
	  notifyAll
	end
	
	@gameModel.makeMove(@player, column)
	notifyAll
	
      rescue Model::Board::ColumnFullException
	puts "[Log]Tried to play in a full column"
      rescue Model::Game::NotYourTurnException
	puts "[Log]Tried to play out of turn"
      end unless @buttonLock

      
      @buttonLock = false
    end 

  end
end
