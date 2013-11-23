require 'test/unit'
require_relative 'win_condition.rb'

module Model

  class Player
    include Test::Unit::Assertions

    attr_writer :winCondition
    attr_reader :name, :color

    def initialize(name, token)
      # -- Pre Conditions -- #
      assert(name.is_a?(String))
      assert(token.is_a?(Model::Token))

      # -- Code -- #
      @name = name
      @token = token
      @winCondition = WinCondition.new(
        WinCondition::PatternElement.PLAYER(self),
        WinCondition::PatternElement.PLAYER(self),
        WinCondition::PatternElement.PLAYER(self),
        WinCondition::PatternElement.PLAYER(self)
      )

      # -- Post Conditions -- #
      assert_equal(@name,name)
      assert_equal(@token,token)
    end

    def makeMove(board,colNumber)
      # -- Pre Conditions -- #
      assert(!board.nil?)
      assert(board.is_a?Model::Board)
      assert(colNumber.is_a?(Integer))
      assert(colNumber >= 0 && colNumber < board.size[:columns])
      tokens_before_addition = board.numTokens(colNumber)
      # -- Code -- #

      board.addPiece(colNumber, self)

      # -- Post Conditions -- #
      assert_equal(board.numTokens(colNumber), tokens_before_addition + 1)
      assert_equal(board.who(colNumber,board.size[:rows] - tokens_before_addition - 1),self)
    end

    def hasWon?(board)
      assert(!@winCondition.nil?)

      @winCondition.hasWon?(board)

    end

    def to_s
      "#{@name}"
    end
  end
end
