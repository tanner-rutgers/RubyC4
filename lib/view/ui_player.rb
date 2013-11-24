require 'test/unit'

require_relative 'ui_observer.rb'

module View
	class UiPlayer
		include Test::Unit::Assertions
		include UiObserver

		def initialize(builder, player)
			# Preconditions
			assert(builder.is_a?Gtk::Builder)
			assert(player.is_a?Model::Player)

			@builder = builder
			@player = player

			getObjects
			initializeDropdowns
			update

			# Postconditions
			assert(!@builder.nil?)
			assert(!@player.nil?)
			assert(!@colourDropdown.nil?)
			assert(!@playerLabel.nil?)
		end

		def getObjects
			@colourDropdown = @builder.get_object("playerColour")
			@playerLabel = @builder.get_object("playerLabel")
			@playerWins = @builder.get_object("playerWins")
			@playerTurnImage = @builder.get_object("playerTurnImage")
		end

		def initializeDropdowns
			Model::Colour.constants.each { |colour|
				@colourDropdown.insertText(colour.to_s)
			}
		end

		def update
			@playerLabel.set_label(@player.name)
			@playerWins.set_text(@player.totalWins.to_s)
		end

	end
end