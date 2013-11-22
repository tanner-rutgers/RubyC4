require 'test/unit'

module Model

  class Player
    include Test::Unit::Assertions

    attr_accessor :winCondition

    def initialize(name)
      # -- Pre Conditions -- #
      assert(name.is_a?(String))

      # -- Code -- #
      @name = name

      # -- Post Conditions -- #
      assert_equal(@name,name)
    end

    def makeMove(board,colNumber)
      # -- Pre Conditions -- #
      assert(!board.nil?)
      assert(board.is_a?Model::Board)
      assert(colNumber.is_a?(Integer))
      assert(colNumber >= 0 && colNumber < board.colSize)
      tokens_before_addition = board.numTokens(colNumber)
      # -- Code -- #

      board.addPiece(colNumber, self)

      # -- Post Conditions -- #
      assert_equal(board.numTokens(colNumber), tokens_before_addition + 1)
      assert_equal(board[colNumber][tokens_before_addition],self)
    end

    def hasWon?(board)
      assert(!@winCondition.nil?)

      @winCondition.hasWon?(board)

    end

    def to_s
      "Model::Player #{@name}"
    end
  end
end
