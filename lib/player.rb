class Player
  include Test::Unit::TestCase

	def initialize(name,winCondition)
		assert(@name.is_a?String)
    assert(winCondition.is_a?WinCondition)

		@name = name
		@windCondition = winCondition

    assert_equal(@name, name)
    assert_equal(@windCondition, winCondition)

	end
	def makeMove(board,column)

    # -- Preconditions -- #
    old_count = board.numTokens(column)
    assert(!board.nil?)
    assert(column < board.size[1])


    # -- Postconditions -- #
    assert_equal(board.numTokens(column), old_count+1)
    assert(board.who(old_count, column), self)
  end

  def hasWon?(board)
    assert(!@winCondition.nil?)
  end

end
