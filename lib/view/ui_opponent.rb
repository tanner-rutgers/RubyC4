require 'test/unit'

require_relative 'ui_player.rb'

module View
	class UiOpponent < View::UiPlayer

		def getObjects
			@colourDropdown = @builder.get_object("opponentColour")
			@playerLabel = @builder.get_object("opponentLabel")
			@playerWins = @builder.get_object("opponentWins")
			@playerTurnImage = @builder.get_object("opponentTurnImage")	
		end	

		def initializeDropdowns
			super
			if @player.is_a?Model::AI
				Model::AI.difficulties.each { |diff| 
					@builder.get_object('difficultyBox').insertText(diff.to_s)
				}
			else
				@builder.get_object('difficultyView').hide_all
			end
		end	
	end
end