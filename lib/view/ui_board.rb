require 'test/unit'
require_relative 'observer.rb'

class Board
	include Observer
	include Test::Unit::Assertions

	def initialize(gameModel)
		# Pre-conditions #
		assert(board.is_a?Model::Game)

		@gameModel = gameModel
		@playerTokens = Array.new
		@playerTokens.add(View::UiToken.new(gameModel.players[0]))
		@playerTokens.add(View::UiToken.new(gameModel.players[1]))
		update

		# Post-conditions / Class-invariants #
		assert(!@gameModel.nil?, "Board model not initialized")
		assert(!@playerTokens.nil?, "Player tokens not initialized")
	end

	# Update all spaces on board
	def update
		# Pre-conditions #
		
		@playerTokens.each { |token| token.update }

		0.upto(@gameModel.board.size.rows) { |i| 
			0.upto(@gameModel.board.size.columns) { |j| 
				player = @gameModel.board.who(i,j)
				file = nil
				@playerTokens.each { |token| file = token.getImageFile if token.player == player } 
				file = "./resources/empty.png" if fil.nil?
				@builder.get_object("piece" + (i*@gameModel.board.size.rows+j).to_s).set_from_file(file)				
			}
		}
		# Post-conditions #	
	end

	# Update given space on board (assumes space will be filled)
	def update(i, j)
		currentPlayer = @gameModel.currentPlayersTurn
		piece = (i*@gameModel.board.size.rows+j).to_s

		@playerTokens.each { |token|
			@builder.get_object("piece" + piece).set_from_file(token.getImageFile) if token.player == player
		}
	end
end