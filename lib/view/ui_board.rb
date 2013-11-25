require 'test/unit'
require_relative 'ui_observer.rb'
require_relative 'ui_token.rb'

module View
	class UiBoard
		include UiObserver
		include Test::Unit::Assertions

		def initialize(builder, gameModel)
			# Pre-conditions #
			assert(builder.is_a?Gtk::Builder)
			assert(gameModel.is_a?Model::Game)

			@builder = builder
      @gameModel = gameModel
			initializeTokens
			update

			# Post-conditions / Class-invariants #
			assert(!@builder.nil?, "Builder was not initialized")
			assert(!@gameModel.nil?, "Game model not initialized")
			assert(!@playerTokens.nil?, "Player tokens not initialized")
		end

		def initializeTokens
			@playerTokens = Array.new

			@gameModel.board.size[:columns].times { |i|
				@gameModel.board.size[:rows].times { |j|
					@playerTokens.push(View::UiToken.new(@builder,@gameModel,i,j))
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
		def updateSpace(i, j)
			
			@playerTokens.each { |token| token.update if token.i == i && token.j == j }
		end
	end
end
