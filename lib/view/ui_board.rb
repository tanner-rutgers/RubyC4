require 'test/unit'
require_relative 'ui_observer.rb'

module View
	class Board
		include UiObserver
		include Test::Unit::Assertions

		def initialize(builder, boardModel)
			# Pre-conditions #
			assert(builder.is_a?Gtk::Builder)
			assert(boardModel.is_a?Model::Board)

			@builder = builder
			@boardModel = boardModel
			initializeTokens
			update

			# Post-conditions / Class-invariants #
			assert(!@builder.nil?, "Builder was not initialized")
			assert(!@boardModel.nil?, "Board model not initialized")
			assert(!@playerTokens.nil?, "Player tokens not initialized")
		end

		def initializeTokens
			@playerTokens = Array.new

			0.upto(@boardModel.size.rows) { |i|
				0.upto(@boardModel.size.columns) { |j|
					@playerTokens.add(View::UiToken.new(@builder,@boardModel,i,j))
				}
			}
		end

		# Update all spaces on board
		def update
			# Pre-conditions #
			
			@playerTokens.each { |token| token.update }

			# Post-conditions #	
		end

		# Update given space on board
		def update(i, j)
			
			@playerTokens.each { |token| token.update if token.i == i && token.j == j }
		end
	end
end