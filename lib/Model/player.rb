require 'test/unit'

module Model

  class Player
    include Test::Unit::Assertions

    def initialize(name,winCondition,pieces)
      # -- Pre Conditions -- #
      assert(name.is_a?(String))
      assert(winCondition.is_a?(WinCondition))

      # -- Code -- #
      @pieces = pieces
      @name = name
      @winCondition = winCondition

      # -- Post Conditions -- #
      assert_equal(@pieces,pieces)
      assert_equal(@name,name)
      assert_equal(@winCondition,winCondition)
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
      end
  end
end
