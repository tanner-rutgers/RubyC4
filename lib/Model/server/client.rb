require 'test/unit'
require 'xmlrpc/client'

module Model
  class Client
    
    class AccessDeniedException < StandardError;
    end
    
    
      
    def initialize(username, password)
      #preconditions
      assert(username.is_a?String)
      assert(password.is_a?String)
      
      #preconditions
      assert_equal(@username, username)
      assert_equal(@password, password)
    end
    
    ## ---- Gameplay Commands ---- ##
    def newGame
      serverConnection.newGame(@username, @password)
    end   

    def makeMove(gameId, move)
      assert(gameId.is_a?Integer)
      assert(move.is_a?Integer)
      
      serverConnection.makeMove(gameId, @username, @password, move)
    end
    
    def getBoard(gameId)
      assert(gameId.is_a?Integer)
            
      rval = serverConnection.getBoard(gameId, @username, @password)

      assert(rval.is_a?(Game) || rval.nil?)
      
      rval
    end

    def whosTurn(gameId)
      assert(gameId.is_a?Integer)
      
      rval = serverConnection.whosTurn(gameId, @username, @password)
      
      assert(rval.is_a?Player)
      
      rval
    end

    def getPlayers(gameId)
      assert(gameId.is_a?Integer)
      
      rval = serverConnection.getPlayers(gameId, @username, @password)
            
      rval
    end
    
    def getWinner(gameId)
      assert(gameId.is_a?Integer)
      
      rval = serverConnection.getWinner(gameId, @username, @password)
      
      assert(rval.is_a?Player || rval.nil?)
      
      rval
    end
   
    
    ## ---- UI Info Commands ---- ##
    def getGameList
      rval = serverConnection.getGameList(@username, @password)
      
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Integer))}
      
      rval
    end

    def getLeaderboard
      rval = serverConnection.getLeaderboard(@username, @password)

      #post-conditions
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Array) && element.size == 2)}
      
      rval
    end

    private
    def serverConnection
      XMLRPC::Client.new("","").proxy("server")
    end
    
  end
end
