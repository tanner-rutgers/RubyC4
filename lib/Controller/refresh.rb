require_relative '../Model/ai.rb'
require_relative '../Model/observer.rb'
require_relative 'observable.rb'

module Controller
  class Refresh
    include Model::Observer
    include Controller::Observable

    
    def initialize(builder, player, opponent, gameModel)  
      @builder = builder
      @player = player
      @opponent = opponent
      @gameModel = gameModel    

    end

    def notify
      Thread.new {
	while(@gameModel.currentPlayersTurn == opponent) 
	  sleep(1)
	end
	@gameModel.refresh
	notifyAll  
      }
    end
    
  end

end

