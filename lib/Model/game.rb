require 'test/unit'
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'settings.rb'

module Model
  class Game < Test::Unit::TestCase

    class NotYourTurnException < StandardError; end

    attr_reader :winner

    def initialize(players, board = Board.new(7, 6))
      # -- Pre Condiditions -- #
      assert(players.is_a?Array)
      assert(players.size >= 2)
      players.each {|x| assert(x.is_a?Player)}


      # -- Code -- #
	  @settings = Settings.new
      @players = players
	  @board = board
      @currentPlayersTurn = players[0]
      @winner = nil

      # -- Post Conditions -- #
      assert(@players.is_a?Array)
      assert(!@board.nil?)
      assert(@currentPlayersTurn == players[0])

    end


    def currentTurn?(player)
      # -- Pre Conditions -- #
      assert(player.is_a?Player)
      assert(@players.include?(player))

      # -- Code -- #
      return @currentPlayersTurn == player

      # -- Post Conditions -- #
      #    None
    end

    def makeMove(player, column)
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
