require 'test/unit'
require_relative 'win_condition.rb'
require_relative 'colour.rb'

module Model

  class Player
    include Test::Unit::Assertions

    attr_writer :winCondition
    attr_reader :name, :colour, :totalWins

    def initialize(name, colour)
      # -- Pre Conditions -- #
      assert(name.is_a?(String))
      assert(Colour.constants.include?colour)

      # -- Code -- #
      @name = name
      @colour = colour
      @winCondition = WinCondition.new(
        Model::WinCondition::PatternElement.PLAYER(self),
        Model::WinCondition::PatternElement.PLAYER(self),
        Model::WinCondition::PatternElement.PLAYER(self),
        Model::WinCondition::PatternElement.PLAYER(self)
      )
      @totalWins = 0

      # -- Post Conditions -- #
      assert_equal(@name,name)
      assert_equal(@colour,colour)
      assert(@totalWins.is_a?Numeric)
    end

    def makeMove(board,colNumber)
      # -- Pre Conditions -- #
      assert(!board.nil?)
      assert(board.is_a?(Model::Board))
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

      hasWon = @winCondition.hasWon?(board)
      @totalWins += 1 if hasWon

      hasWon
    end

    def to_s
      "#{@name}"
    end
  end
end
