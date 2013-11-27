require 'test/unit'
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'settings.rb'
require_relative 'colour.rb'

module Model
  class ClientGame < Game

    #All methods from "Game" will need to be rewritten, to contact the server for this information. Contracts will not change.


    def to_s
      str = "Current Turn: #{@currentPlayersTurn} \t Game Over: #{@currentPlayersTurn.nil?} \t Winner: #{@winner}\n"
      str += @board.to_s
    end
  end
end
