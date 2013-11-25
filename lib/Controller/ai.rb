require_relative '../Model/ai.rb'
require_relative '../Model/observer.rb'
require_relative 'observable.rb'

module Controller
  class AI
    include Model::Observer
    include Controller::Observable

    
    def initialize(player, opponent, gameModel)
      @aiPlayer = player
      @ai = Model::AI.new(player, opponent, 3)
      @gameModel = gameModel            
    end
    
    def notify
      @gameModel.makeMove(@aiPlayer, @ai.getBestMove(@gameModel.board)) if @gameModel.currentPlayersTurn == @aiPlayer 
      notifyAll          
    end
    
  end

end

