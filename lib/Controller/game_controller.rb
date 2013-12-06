require 'rubygems'
require 'gtk2'
require 'test/unit'

require_relative '../Model/server/client_game.rb'
require_relative '../Model/game.rb'
require_relative '../view/ui_game.rb'
require_relative 'board.rb'
require_relative 'colour.rb'
require_relative 'ai.rb'
require_relative 'file_menu.rb'
require_relative 'refresh.rb'


class GameController
  include Test::Unit::Assertions

  def initialize(builder, client, opponent, gameId = nil, aiGame = false)  
    @builder = builder
    
    # -- Code -- #
    @gameModel = Model::ClientGame.new(client, opponent, gameId) unless aiGame
    @gameModel = Model::Game.new(Model::Player.new("Bob"), Model::Player.new(opponent)) if aiGame  
    
    game = View::UiGame.new(@builder, @gameModel)

    boardController = Controller::Board.new(@builder, @gameModel, @gameModel.players[0])
    boardController.addObserver(game.get_view(View::UiBoard)) 
    boardController.addObserver(game.get_view(View::UiStatusInfo))

    if(aiGame)
      aiController = Controller::AI.new(@builder, @gameModel.players[0], @gameModel.players[1], @gameModel)
      aiController.addObserver(game.get_view(View::UiBoard))
      aiController.addObserver(game.get_view(View::UiStatusInfo))
      #When someone makes a move it will notify the AI controller it needs to make the next move.
      boardController.addObserver(aiController)
    else
      refreshController = Controller::Refresh.new(@builder, @gameModel.players[0], @gameModel.players[1], @gameModel)
      refreshController.addObserver(game.get_view(View::UiBoard))
      refreshController.addObserver(game.get_view(View::UiStatusInfo))
      #When someone makes a move it will notify the AI controller it needs to make the next move.
      boardController.addObserver(refreshController)
    end    
   
    colourController = Controller::Colour.new(@builder, game.get_view(View::UiBoard).playerColourMap, @gameModel.players[0], @gameModel.players[1])
    colourController.addObserver(game.get_view(View::UiBoard))

    fileMenuController = Controller::FileMenu.new(@builder, @gameModel)
    fileMenuController.addObserver(game.get_view(View::UiBoard))
    fileMenuController.addObserver(game.get_view(View::UiStatusInfo))

    game.show

    # -- Post Conditions -- #
  end

end

