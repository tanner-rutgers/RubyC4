require_relative 'observable.rb'

module Controller
  class FileMenu
    include Observable

    def initialize(builder, gameModel)
      @gameModel = gameModel
      @builder = builder         

      setupHandlers
    end
    
    def setupHandlers
#       newButton   =  @builder.get_object("newButton")
#       exitButton  =  @builder.get_object("exitButton")
# 
#       newButton.signal_connect( "activate" ) { newButtonAction }
#       exitButton.signal_connect( "activate" ) { Gtk.main_quit }
    end

    def newButtonAction
      @gameModel.clearBoard
      notifyAll  
    end

    def saveButtonAction
      
      notifyAll  
    end

    def loadButtonAction
      
      notifyAll    
    end

  end
end
