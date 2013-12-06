require 'test/unit'
require 'xmlrpc/utils.rb'
module Model

  class Player
    include Test::Unit::Assertions
    
    attr_accessor :name

    def initialize(name)
      # -- Pre Conditions -- #
      assert(name.is_a?(String))

      # -- Code -- #
      @name = name
      @winCondition = [:player, :player, :player, :player]

      # -- Post Conditions -- #
      assert_equal(@name,name)
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
      boardSize = board.size
      boardSize[:columns].times do |i|
        boardSize[:rows].times do |j|
          lines = board.getLines(i, j, @winCondition.size)

          lines.each do |line|
            hasWon = true
            @winCondition.each_with_index do |patternElement, index|
	      hasWon &= line[index].eql?(self)  	if patternElement == :player
	      hasWon &= !line[index].eql?(self) 	if patternElement == :other
	      hasWon &= line[index].is_a?(Player) 	if patternElement == :any
            end

            return hasWon if hasWon
          end
        end
      end
      return false
    end

    # -- Object Methods -- #
    def to_s
      "#{@name}"
    end
    
    def eql? (other)
      other.is_a?(Model::Player) && self == other
    end

    def == (other)
      other.respond_to?(:name) && other.name == self.name
    end

    def hash
      return "Model::Player".hash ^ @name.hash
    end
    
  end
end
