require 'test/unit'

module Model
  class Game < Test::Unit::TestCase
    def initialize()
      # -- Pre Condiditions -- #
      assert(players.is_a?Array)
      assert(players.size >0)
      players.each {|x| assert(x.kind_of(String))}


      # -- Code -- #
      @players = Array.new
	  @board = Board.new
	  @settings = Array.new

      # -- Post Conditions -- #
      assert(@players.is_a?Array)
	  assert(@settings.is_a?Array)
      assert(!@board.nil?)

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
end
