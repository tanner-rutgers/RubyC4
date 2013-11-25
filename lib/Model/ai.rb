require 'test/unit'
require_relative 'player.rb'
module Model
  class AI
    attr_writer :difficulty

    def initialize(opponent,player,difficulty)
      # -- Pre Conditions -- #
      
      # -- Code -- #
      @player = player
      @opponent = opponent
      @difficulty = difficulty
      
      # -- Post Conditions -- #
    end
    
    
    def getBestMove(board)
        # -- Pre Conditions -- #
        # -- Code -- #
        bestMove = 0
        bestValue = -1000
        
        for x in 0..6
            test = board.clone
            begin
                test.addPiece(x,@player)
                value = minimax(test,@difficulty,false)
                if value > bestValue
                    bestMove = x
                    bestValue = value
                elsif value == bestValue
                    bestMove = rand.round == 1 ? bestMove : x
                end
                rescue Model::Board::ColumnFullException
            end
        end
        return bestMove
        
        # -- Post Conditions -- #
    end


    def minimax(board, depth, maximizingPlayer)
        bestValue = 0
        newBoard = board
        if depth == 0 || board.isFull? || @player.hasWon?(board) || @opponent.hasWon?(board)
            return 100*depth + 1 if @player.hasWon?(newBoard) && !maximizingPlayer
            return -100*depth + 1 if @opponent.hasWon?(newBoard) && maximizingPlayer
            return 0
        end
        if maximizingPlayer
            bestValue = -100
            for x in 0..6
                begin
                    newBoard = board.clone
                    newBoard.addPiece(x,@player)
                    rescue
                end
                val = minimax(newBoard,depth-1,false)
                bestValue = [val,bestValue].max
            end
            return bestValue
        else
            bestValue = +100
            for x in 0..6
                begin
                    newBoard = board.clone
                    newBoard.addPiece(x,@opponent)
                rescue
                end
                val = minimax(newBoard,depth-1,true)
                bestValue = [val,bestValue].min
            end

            return bestValue
        end
    end
  end
end
