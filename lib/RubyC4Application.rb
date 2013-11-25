require_relative 'Controller/game_controller.rb'
require_relative 'Model/game.rb'

class RubyC4Application
    @@game_model = nil
	@@game_controller = nil

	def initialize
		getGameController()
	end

    def getGame()
        if (@@game_model == nil)
            @@game_model = Model::Game.new()
        end
		return @@game_model
	end

    def getGameController()
        if (@@game_controller == nil)
            @@game_controller = GameController.new(getGame())
		end
        return @@game_controller
    end
end
