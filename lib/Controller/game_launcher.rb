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

  @@refresher = nil;
  
  def self.AILauncher(builder, client, gameType)
    @@refresher.kill unless @@refresher.nil?

    # -- Code -- #
    gameModel = Model::Game.new(client.getPlayer, Model::Player.new("AI-Bob"))
    gameModel.players.each do |player|
	  player.winCondition = [:player, :player, :player, :player] if gameType == :connect4
	  player.winCondition = [:player, :other, :other, :player] if gameType == :otto
    end
    
    game = View::UiGame.new(builder, gameModel)
    
    boardController = Controller::Board.new(builder, gameModel, gameModel.players[0])
    boardController.addObserver(game.get_view(View::UiBoard)) 
    boardController.addObserver(game.get_view(View::UiStatusInfo))

    aiController = Controller::AI.new(builder, gameModel.players[0], gameModel.players[1], gameModel)
    aiController.addObserver(game.get_view(View::UiBoard))
    aiController.addObserver(game.get_view(View::UiStatusInfo))
    #When someone makes a move it will notify the AI controller it needs to make the next move.
    boardController.addObserver(aiController)
   
    colourController = Controller::Colour.new(builder, game.get_view(View::UiBoard).playerColourMap, gameModel.players[0], gameModel.players[1])
    colourController.addObserver(game.get_view(View::UiBoard))
    
    return GameLauncher.new(game)
    
  end

  def self.NewGameLauncher(builder, client, opponent, gameType)
    @@refresher.kill unless @@refresher.nil?
     
   
   
    gameModel = Model::ClientGame.new(client, opponent, gameType)
    
    game = View::UiGame.new(builder, gameModel)
    
    boardController = Controller::Board.new(builder, gameModel, client.getPlayer)
    boardController.addObserver(game.get_view(View::UiBoard)) 
    boardController.addObserver(game.get_view(View::UiStatusInfo))

    refreshController = Controller::Refresh.new(builder, client.getPlayer, gameModel)
    refreshController.addObserver(game.get_view(View::UiBoard))
    refreshController.addObserver(game.get_view(View::UiStatusInfo))
    #When someone makes a move it will notify the refresher to start refreshing again..
    boardController.addObserver(refreshController)
    #Start refreshing immediately. -- Will stop immediately if it's currently the users turn, otherwise will continue until it becomes his turn
    refreshController.notify
    @@refresher = refreshController;
     
   
    colourController = Controller::Colour.new(builder, game.get_view(View::UiBoard).playerColourMap, gameModel.players[0], gameModel.players[1])
    colourController.addObserver(game.get_view(View::UiBoard))
    
    return GameLauncher.new(game)
  end
  
  def self.ExistingGameLauncher(builder, client, gameId)
    @@refresher.kill unless @@refresher.nil?   
   
    gameModel = Model::ClientGame.new(client, "", :connect4, gameId)
    game = View::UiGame.new(builder, gameModel)
    
    boardController = Controller::Board.new(builder, gameModel, client.getPlayer)
    boardController.addObserver(game.get_view(View::UiBoard)) 
    boardController.addObserver(game.get_view(View::UiStatusInfo))

    refreshController = Controller::Refresh.new(builder, client.getPlayer, gameModel)
    refreshController.addObserver(game.get_view(View::UiBoard))
    refreshController.addObserver(game.get_view(View::UiStatusInfo))
    #When someone makes a move it will notify the refresher to start refreshing again..
    boardController.addObserver(refreshController)
    #Start refreshing immediately. -- Will stop immediately if it's currently the users turn, otherwise will continue until it becomes his turn
    refreshController.notify
    @@refresher = refreshController;
     
   
    colourController = Controller::Colour.new(builder, game.get_view(View::UiBoard).playerColourMap, gameModel.players[0], gameModel.players[1])
    colourController.addObserver(game.get_view(View::UiBoard))
    
    return GameLauncher.new(game)
  end
  
  def show
      @game.show  
  end
  
  private
  def initialize(game)  
    @game = game
  end

end

