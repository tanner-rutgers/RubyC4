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
      newButton   =  @builder.get_object("newButton")
      #saveButton  =  @builder.get_object("saveButton")
      #loadButton  =  @builder.get_object("loadButton")
      exitButton  =  @builder.get_object("newButton")

      newButton.signal_connect( "activate" ) { newButtonAction }
      #saveButton.signal_connect( "activate" ) { saveButtonAction }
      #loadButton.signal_connect( "activate" ) { loadButtonAction }
      exitButton.signal_connect( "activate" ) { exitButtonAction }
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

    def exitButtonAction
      
      notifyAll
    end

  end
end
