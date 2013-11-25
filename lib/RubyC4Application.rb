class RubyC4Application
    @@game_model = nil
	@@game_controller = nil

	def initialize
		
	end

    def getGame() {
        if (@@game_model == nil)
            @@game_model = Model::Game.new ;
    	end
		return @@game_model
	end

    // Singleton
    transient private static GameController gameController = null;

    def getGameController()
        if (@@game_controller == nil)
            @@game_controller = GameController.new(getGame())
		end
        return @@game_controller
    end

}
