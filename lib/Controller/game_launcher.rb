require 'rubygems'
require 'gtk2'
require 'test/unit'

require_relative '../Model/server/client_game.rb'
require_relative '../Model/game.rb'
require_relative '../view/ui_game.rb'
require_relative 'board.rb'
require_relative 'colour.rb'
require_relative 'ai.rb'
require_relative 'refresh.rb'


class GameLauncher
  include Test::Unit::Assertions

  def initialize(builder, client, opponent, gameType = :connect4, gameId = nil, aiGame = false)  
    @builder = builder
    
    # -- Code -- #
    if(aiGame)
      @gameModel = Model::Game.new(Model::Player.new("Bob"), Model::Player.new(opponent))
      @gameModel.players.each do |player|
	    player.winCondition = [:player, :player, :player, :player] if gameType == :connect4
	    player.winCondition = [:player, :other, :other, :player] if gameType == :otto
      end
    else
	@gameModel = Model::ClientGame.new(client, opponent, gameType, gameId)
    end
    
    @game = View::UiGame.new(@builder, @gameModel)
    
    boardController = Controller::Board.new(@builder, @gameModel, aiGame ? @gameModel.players[0] : client.getPlayer)
    boardController.addObserver(@game.get_view(View::UiBoard)) 
    boardController.addObserver(@game.get_view(View::UiStatusInfo))

    if(aiGame)
      aiController = Controller::AI.new(@builder, @gameModel.players[0], @gameModel.players[1], @gameModel)
      aiController.addObserver(@game.get_view(View::UiBoard))
      aiController.addObserver(@game.get_view(View::UiStatusInfo))
      #When someone makes a move it will notify the AI controller it needs to make the next move.
      boardController.addObserver(aiController)
    else
      refreshController = Controller::Refresh.new(@builder, client.getPlayer, @gameModel)
      refreshController.addObserver(@game.get_view(View::UiBoard))
      refreshController.addObserver(@game.get_view(View::UiStatusInfo))
      #When someone makes a move it will notify the refresher to start refreshing again..
      boardController.addObserver(refreshController)
      #Start refreshing immediately. -- Will stop immediately if it's currently the users turn, otherwise will continue until it becomes his turn
      refreshController.notify
    end    
   
    colourController = Controller::Colour.new(@builder, @game.get_view(View::UiBoard).playerColourMap, @gameModel.players[0], @gameModel.players[1])
    colourController.addObserver(@game.get_view(View::UiBoard))
    
    # -- Post Conditions -- #
  end

  def show
      @game.show  
  end
end

