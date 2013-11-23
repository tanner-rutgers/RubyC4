require 'test/unit'

require_relative 'observable.rb'

class Board
	include Test::Unit::Assertions
	include Observable

	def initialize(builder, gameModel, boardView, player)
		#Preconditions
		assert(builder.is_a?Gtk::Builder)
		assert(gameModel.is_a?Model::Game)
		assert(boardView.is_a?View::Board)
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
		1.upto(@gameModel.board.size.columns) { |i|
			@builder.get_object("dropButton" + i.to_s).signal_connect("clicked") { dropButtonClicked(i) }
		}
	end

	def dropButtonClicked(column)
		begin 
			@gameModel.makeMove(@player, column-1)
		rescue Model::Board::ColumnFullException
			return
		rescue Model::Game::NotYourTurnException
			return
		end

		@boardView.update
	end
  
end