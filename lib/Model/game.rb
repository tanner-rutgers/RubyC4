require 'test/unit'
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'settings.rb'
require_relative 'colour.rb'

module Model
  class Game
    include Test::Unit::Assertions

    class NotYourTurnException < StandardError; end

    attr_reader :winner, :board, :players, :currentPlayersTurn

    def initialize()
      # -- Pre Condiditions -- #
      players.each {|x| assert(x.is_a?Model::Player)}


      # -- Code -- #
	  @players = Array.new([Player.new("Player1", Colour.RED), Player.new("Player2", Colour.BLUE)])
	  @settings = Settings.new()
	  @board = Board.new(7, 6)
      @currentPlayersTurn = players[0]
      @winner = nil

      # -- Post Conditions -- #
      assert(@players.is_a?Array)
      assert(!@board.nil?)
      assert(@currentPlayersTurn == players[0])

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
      
      raise NotYourTurnException if !currentTurn?(player)

      player.makeMove(@board, column)
      endTurn()

    end

    # returns true if current player won on his turn, or if he filled the board and there is no winner.
    # if there is no winner @currentPlayersTurn will be nil.
    def endTurn

      if(@currentPlayersTurn.hasWon?(@board))
        @winner = @currentPlayersTurn
        @currentPlayersTurn = nil
        return true;
      elsif(@board.isFull?)
        @currentPlayersTurn = nil
        return true
      end

      index = @players.find_index(@currentPlayersTurn)
      next_index = (index + 1) % @players.size

      @currentPlayersTurn = @players[next_index]
    end

    def gameOver?
      @currentPlayersTurn.nil?
    end

    def to_s
      str = "Current Turn: #{@currentPlayersTurn} \t Game Over: #{@currentPlayersTurn.nil?} \t Winner: #{@winner}\n"
      str += @board.to_s
    end
  end
end
