require 'test/unit'

class Game < Test::Unit::TestCase
	def initialize(players)
		# -- Pre Condiditions -- #
		assert(players.is_a?Array)
		assert(players.size >0)
		players.each {|x| assert(x.kind_of(String))}
				

		# -- Code -- #
		@players = players

		# -- Post Conditions -- #
		assert_equal(@players,players)
		assert(!@board.nil?)
		
	end
	def startGame()
		# -- Pre Conditions -- #
		assert(!@board.nil?)
		
	
		# -- Code -- #

		# -- Post Conditions -- #
		assert(!@currentPlayersTurn.nil?)
		assert(@players.include?(@currentPlayersTurn))	
	end
	def currentTurn?(player)
		# -- Pre Conditions -- #
		assert(player.is_a?Player)
		assert(players.include?(player))
		
		# -- Code -- #
		
		# -- Post Conditions -- #
		#    None
	end
	def endTurn()
		
		current = @currentPlayersTurn
		# -- Code -- #

		# -- Post Conditions --#
		assert(@currentPlayersTurn != current)		
	end
	def createBoard(rowSize, colSize)	
		# -- Pre Conditions -- #
		assert(rowSize.is_a?(Integer))
		assert(colSize.is_a?(Integer))

		# -- Code -- #

		# -- Post Conditions -- #
		assert_equal(@board.size, [rowSize, colSize])
		@board.each { |x| assert_equal(x.size,colSize)}
	end
end
