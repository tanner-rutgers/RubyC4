require 'test/unit'
require_relative 'player.rb'
require_relative 'win_condition.rb'
module Model

  class AI < Model::Player
    def initialize(name,colour)
      # -- Pre Conditions -- #

      # -- Code -- #
      @name = name

	@winCondition = WinCondition.new(
        	Model::WinCondition::PatternElement.PLAYER(self),
        	Model::WinCondition::PatternElement.PLAYER(self),
        	Model::WinCondition::PatternElement.PLAYER(self),
        	Model::WinCondition::PatternElement.PLAYER(self)
     	)	

      # -- Post Conditions -- #
    end

	def opponent(player)
		@player = player
	end

    def makeMove(board,col)
      # -- Pre Conditions -- #
      # -- Code -- #
	bestMove = 0
	bestValue = -1000
	
	for x in 0..6
		test = board.clone
		begin 
			test.addPiece(x,self)
			value = minimax(test,2,false)
			#puts "best value = #{value} and row = #{x}"
			if value > bestValue
				bestMove = x
				bestValue = value
			end

#			puts "mov = #{x} and value = #{value}"
		rescue
#			puts $!
		end
	end
	puts "best move = #{bestMove}"
	board.addPiece(bestMove,self)
	
      # -- Post Conditions -- #
    end
  end
	
	def minimax(board, depth, maximizingPlayer)
		bestValue = 0
		newBoard = board
		if depth == 0 || board.isFull? || @player.hasWon?(board) || self.hasWon?(board)
			#puts "player.haswon = #{@player.hasWon?(board)} self.hasWon? = #{self.hasWon?(board)}"
			#puts "depth = #{depth} and board.isFull? = #{board.isFull?}"
			#puts board 
			return 100*depth + 1 if self.hasWon?(newBoard) && !maximizingPlayer 
			return -100*depth + 1 if @player.hasWon?(newBoard) && maximizingPlayer
			return 0
		end
		if maximizingPlayer
			bestValue = -100
			for x in 0..6
				begin 
					newBoard = board.clone
					newBoard.addPiece(x,self)
				rescue
				end
				val = minimax(newBoard,depth-1,false)
				bestValue = [val,bestValue].max 
			end
			#puts "bestValue = #{bestValue}"
			return bestValue
		else
			bestValue = +100
			for x in 0..6
				begin
					newBoard = board.clone
					newBoard.addPiece(x,@player)
				rescue
				end
				val = minimax(newBoard,depth-1,true)
				bestValue = [val,bestValue].min
			end
			return bestValue
		end
	end
    def hasWon?(board)
      hasWon = @winCondition.hasWon?(board)

    end
end
