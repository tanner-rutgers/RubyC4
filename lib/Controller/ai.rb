require_relative '../Model/ai.rb'
require_relative '../Model/observer.rb'
require_relative 'observable.rb'

module Controller
  class AI
    include Model::Observer
    include Controller::Observable

    
    def initialize(builder, player, opponent, gameModel)  
      @builder = builder
      @aiPlayer = opponent
      @ai = Model::AI.new(player, opponent, 1)
      @gameModel = gameModel    

      setupHandlers        
    end

    def setupHandlers
      easyButton   =  @builder.get_object("easyButton")
      mediumButton =  @builder.get_object("mediumButton")
      hardButton   =  @builder.get_object("hardButton")

      easyButton.signal_connect( "activate" ) { difficultyHandler(1) }
      mediumButton.signal_connect( "activate" ) { difficultyHandler(3) }
      hardButton.signal_connect( "activate" ) { difficultyHandler(4) }

    end   

    def difficultyHandler(difficulty)
      @ai.difficulty = difficulty    
    end
    
    def notify
      Thread.new {
        @gameModel.makeMove(@aiPlayer, @ai.getBestMove(@gameModel.board)) if @gameModel.currentPlayersTurn == @aiPlayer 
        notifyAll  
      }
    end
    
  end

end

