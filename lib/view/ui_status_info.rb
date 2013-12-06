require 'test/unit'
require_relative 'ui_observer.rb'

module View
  class UiStatusInfo
    include UiObserver
    include Test::Unit::Assertions

    def initialize(builder, gameModel)
      # Pre-conditions #
      assert(builder.is_a?Gtk::Builder)
      assert(gameModel.is_a?Model::Game)

      @statusLabel = builder.get_object('statusLabel')
      @gameModel = gameModel

      update

      # Post-conditions / Class-invariants #
      assert(!@statusLabel.nil?, "Status Label was not initialized")
      assert(!@gameModel.nil?, "Game model not initialized")

    end


    # Update info in status bar
    def update
      # Pre-conditions #

      statusText = "#{@gameModel.winner.name} Wins!"                  if  @gameModel.gameOver?	&& !@gameModel.winner.nil?		
      statusText = "Draw!"                                            if  @gameModel.gameOver?	&&  @gameModel.winner.nil?		
      statusText = "#{@gameModel.currentPlayersTurn.name}'s Turn..."  if !@gameModel.gameOver?		

      @statusLabel.set_text(statusText)

    # Post-conditions #	
    end

  end
end
