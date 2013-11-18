class Game
	def initialize(players)
		# -- Pre Condiditions -- #
		assert(players.kind_of(Array)
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
		assert(player.kind_of?(String))
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
		assert(rowSize.kind_of?(Integer))
		assert(colSize.kind_of?(Integer))

		# -- Code -- #

		# -- Post Conditions -- #
		assert_equal(@board.size,rowSize)
		@board.each { |x| assert_equal(x.size,colSize)}
	end
end
