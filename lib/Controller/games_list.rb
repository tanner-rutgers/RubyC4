require_relative 'observable.rb'

module Controller
  class GamesList

    def initialize(builder, client, newGameController, gamesList)
      @builder = builder
      @client = client
      @newGameController = newGameController
      @gamesList = gamesList

      setupHandlers
    end
    
    def setupHandlers
      newButton = @builder.get_object("startGameButton")
      exitButton = @builder.get_object("exitProgramButton")
      launchButton = @builder.get_object("launchButton")

      newButton.signal_connect( "activate" ) { newButtonAction }
      exitButton.signal_connect( "activate" ) { Gtk.main_quit }
      launchButton.signal_connect ( "clicked" ) {launchButtonAction}

      @builder.get_object("launchWindow").signal_connect( "destroy" ) { Gtk.main_quit }
    end

    def newButtonAction
      @newGameController.openNewGameDialog
    end
    
    def launchButtonAction
      gameInfo = getGameInfo;
      GameLauncher::ExistingGameLauncher(@builder, @client, gameInfo[:gameId], @gamesList).show
    end
    
    def getGameInfo
      selection = @builder.get_object('treeview2').selection
      return nil if selection.selected.nil?
      
      selection.selected[0]
      return {
	      :gameId => selection.selected[0],
	      :opponent => selection.selected[1],
	      :type => selection.selected[0] == "Connect 4" ? :connect4 : :otto
	     }
    end

  end
end
