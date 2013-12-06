require 'test/unit'
require_relative '../game.rb'
require_relative '../board.rb'
require_relative '../player.rb'
require_relative '../colour.rb'
require_relative 'client.rb'

module Model
  class ClientGame < Game

    attr_reader :winner, :board, :players, :currentPlayersTurn, :moveComplete
    
    def initialize(client, opponent, gameType, gameId = nil)
      # -- Pre Condiditions -- #
      #Will be username of opponent. Not a player object.
      assert(opponent.is_a?String)
      assert(gameType == :connect4 || gameType == :otto)
      
      # -- Code -- #
      #Game Model Defaults
      @server = client
      @gameId = gameId
      @gameId = @server.newGame(opponent, gameType) if(gameId.nil?)
      @moveComplete = true
      
      puts(@gameId)
      
      refresh
        
      # -- Post Conditions -- #
      assert(@players.is_a?Array)
      assert(!@board.nil?)
    end


    def currentTurn?(player)
      # -- Pre Conditions -- #
      assert(player.is_a?Model::Player)
      assert(@players.include?(player))


      # -- Code -- #
      return @currentPlayersTurn == player

      # -- Post Conditions -- #
      #    None
    end

    # Drops players value in the board, and then ends that players turn.
    # @returns true of the move is a game ending move, otherwise false
    def makeMove(player, column)
      assert(player.is_a?Player)
      assert(column.is_a?Integer)
      
      @server.makeMove(@gameId, column)
      endTurn()
    end

    # returns true if current player won on his turn, or if he filled the board and there is no winner.
    # if there is no winner @currentPlayersTurn will be nil.
    def endTurn
      refresh
      @moveComplete = true
      return gameOver?
    end


    def clearBoard
      @server.clearBoard
    end
    
    def refresh
	@board = @server.getBoard(@gameId)
	@players = @server.getPlayers(@gameId)
	@currentPlayersTurn = @server.whosTurn(@gameId)
	@winner = @server.getWinner(@gameId)
    end
    
    #Makes move on client only.
    def pseudoMakeMove(player, column)
      assert(player.is_a?Player)
      assert(column.is_a?Integer)

      #Pretend to add the piece on client while we wait for server to make the real move      
      raise NotYourTurnException if !currentTurn?(player)
      
      @board.addPiece(column, player)
      self.class.superclass.instance_method(:endTurn).bind(self).call
      #Move has not propogated to server yet.
      @moveComplete = false
    end
    
    
  end
end
