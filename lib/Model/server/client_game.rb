require 'test/unit'
require_relative '../game.rb'
require_relative '../board.rb'
require_relative '../player.rb'
require_relative '../colour.rb'
require_relative 'client.rb'

module Model
  class ClientGame < Game

    attr_reader :winner, :board, :players, :currentPlayersTurn
    
    def initialize(client, opponent, gameId = nil)
      # -- Pre Condiditions -- #
      #Will be username of opponent. Not a player object.
      assert(opponent.is_a?String)

      # -- Code -- #
      #Game Model Defaults
      @server = client
      @gameId = gameId
      @gameId = @server.newGame(opponent) if(gameId.nil?)
      
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

      @currentPlayersTurn = @server.whosTurn(@gameId)

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
      
      @currentPlayersTurn = @server.whosTurn(@gameId)
      
      raise NotYourTurnException if !currentTurn?(player)

      @server.makeMove(@gameId, player, column)
      endTurn()
    end

    # returns true if current player won on his turn, or if he filled the board and there is no winner.
    # if there is no winner @currentPlayersTurn will be nil.
    def endTurn
      @currentPlayersTurn = @server.whosTurn(@gameId)
      @board = @server.getBoard(@gameId)
      @winner = @server.getWinner(@gameId)
      
      return gameOver?
    end

    def gameOver?
      @currentPlayersTurn = @server.whosTurn(@gameId)
      @currentPlayersTurn.nil?
    end

    def clearBoard
      @server.clearBoard
    end

    # -- Override the getters to contact the server -- #
    def winner
	@winner = @winner.getBoard(@gameId)
	return @winner
    end
    
    def board
	@board = @server.getBoard(@gameId)
	return @board
    end
    
    def players
	@players = @server.getPlayers(@gameId)
	return @players
    end
    
    def currentPlayersTurn
	@currentPlayersTurn = @server.whosTurn(@gameId)
    end
    
    def refresh
	@board = @server.getBoard(@gameId)
	@players = @server.getPlayers(@gameId)
	@currentPlayersTurn = @server.whosTurn(@gameId)
	@winner = @server.getWinner(@gameId)
    end
    
    
  end
end
