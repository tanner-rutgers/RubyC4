require 'test/unit'
require_relative 'player.rb'
module Model
    class AI
        def initialize(player,opponent,difficulty)
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
                value = minimax(test,2,false)
                #puts "best value = #{bestValue} and row = #{bestMove}"
                if value > bestValue
                    bestMove = x
                    bestValue = value
                elsif value == bestValue
                    bestMove = rand.round == 1 ? bestMove : x
                end
                
                #			puts "mov = #{x} and value = #{value}"
                rescue
                #			puts $!
                
            end
        end
        return bestMove
        
        # -- Post Conditions -- #
    end
end

    def minimax(board, depth, maximizingPlayer)
        bestValue = 0
        newBoard = board
        if depth == 0 || board.isFull? || @player.hasWon?(board) || @opponent.hasWon?(board)
            #puts "player.haswon = #{@player.hasWon?(board)} self.hasWon? = #{self.hasWon?(board)}"
            #puts "depth = #{depth} and board.isFull? = #{board.isFull?}"
            #puts board
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
        #puts "bestValue = #{bestValue}"
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
