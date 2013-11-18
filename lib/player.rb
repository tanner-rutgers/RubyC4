require 'test/unit'

class Player < Test::Unit::TestCase
	def initialize(name,winCondition,pieces)
		# -- Pre Conditions -- #
		assert(name.is_a?(String))
		assert(winCondition.is_a?(WinCondition))
		
		# -- Code -- #
		@pieces = pieces
		@name = name
		@windCondition = winCondition

		# -- Post Conditions -- #
		assert_equal(@pieces,pieces)
		assert_equal(@name,name)
		assert_euqal(@winCondition,winCondition)
	end
	def makeMove(board,colNumber)	
		# -- Pre Conditions -- #
		assert(!board.nil?)
		assert(colNumber.is_a?(Integer))
		assert(colNumber >= 0 && colNumber < board.colSize)
		tokens_before_addition = board.numTokens(colNumber)
		# -- Code -- #

		# -- Post Conditions -- #
		assert_equal(board.numTokens(colNumber), tokens_before_addition + 1)
		assert_equal(board[colNumber][tokens_before_addition],self)
	end
end
