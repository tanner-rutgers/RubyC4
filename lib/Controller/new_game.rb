require_relative '../Model/player.rb'
require_relative '../Model/colour.rb'
require_relative '../Controller/observable.rb'
require_relative '../Controller/game_launcher.rb'

module Controller
  class NewGame
    include Observable

    @@RESPONSE_ACCEPT = 0
    @@RESPONSE_CANCEL = 3
    
    def initialize(builder, client)
      @builder = builder
      @client = client
    end
    
    def openNewGameDialog
      setupListStore
      
      dialog = @builder.get_object('newGameWindow')
      
      dialog.run do |response|
        case response
          when @@RESPONSE_ACCEPT
	    
	    opponent = getOpponentName
	    opponent = "AI-Bob" if isAI?
	    
	    if(!opponent.nil?)
	      launcher = GameLauncher.new(@builder, @client, opponent, getGameType, nil, isAI?)
	      launcher.show
	      notifyAll
	    end
	    
	    
        end
        dialog.hide      
      end

    end
    
    def isAI?
      @builder.get_object("opponentComputer").active?
    end
    
    def getGameType
      return :otto if @builder.get_object("gameTypeOTTO").active?
      return :connect4
    end
    
    def getOpponentName
      selection = @builder.get_object('treeview1').selection
      username = selection.selected[0] unless selection.selected.nil? 
      return username
    end
      
    def setupListStore 
      listStore = @builder.get_object('userListStore')
      listStore.clear
      
      @client.getUserList.each do |player|
      listStore.append.set_value(0, player)
    end
      
      
    end

    
    
  end
end
