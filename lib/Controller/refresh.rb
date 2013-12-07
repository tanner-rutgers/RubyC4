require_relative '../Model/ai.rb'
require_relative '../Model/observer.rb'
require_relative 'observable.rb'

module Controller
  class Refresh
    include Model::Observer
    include Controller::Observable

    
    def initialize(builder, player, gameModel)  
      @builder = builder
      @player = player
      @gameModel = gameModel    
      @refreshing = false
    end

    def notify
      @refreshThread = Thread.new {
	@refreshing = true
	while(@gameModel.currentPlayersTurn != @player && !@gameModel.currentPlayersTurn.nil?)
	  sleep(5)
	  @gameModel.refresh
	end
	@refreshing = false
	notifyAll  
      } if @gameModel.moveComplete && !@refreshing 
    end
    
    def kill
      Thread.kill(@refreshThread) unless @refreshThread.nil?
    end
    
  end

end

