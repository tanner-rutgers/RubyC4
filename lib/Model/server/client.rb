require 'test/unit'
require 'xmlrpc/client'
require 'yaml'
require_relative '../game.rb'
require_relative '../board.rb'
require_relative '../player.rb'

module Model
  class Client
    include Test::Unit::Assertions

    class AccessDeniedException < StandardError;
    end   
    
      
    def initialize(username, password)
      #preconditions
      assert(username.is_a?String)
      assert(password.is_a?String)
      
      @username = username
      @password = password
      @serverConnection = XMLRPC::Client.new("localhost","/RPC2", 50500).proxy("server")
      
      raise AccessDeniedException if !YAML::load(@serverConnection.login(username, password))
      
      #preconditions
      assert_equal(@username, username)
      assert_equal(@password, password)
      assert(!@serverConnection.nil?)
    end
    
    ## ---- Gameplay Commands ---- ##
    def newGame(opponentUsername)
      rval = YAML::load(@serverConnection.newGame(@username, @password, opponentUsername))
      raise AccessDeniedException if rval == false
      return rval
    end   

    def makeMove(gameId, move)
      assert(gameId.is_a?Integer)
      assert(move.is_a?Integer)
      
      #Make move and raise exception if an credentials are bad.
      rval =  YAML::load(@serverConnection.makeMove(gameId, @username, @password, move))
      raise AccessDeniedException if rval == false
	
    end
    
    def getBoard(gameId)
      assert(gameId.is_a?Integer)
            
      rval = YAML::load(@serverConnection.getBoard(gameId, @username, @password))
      raise AccessDeniedException if rval == false
      
      return rval
    end

    def whosTurn(gameId)
      assert(gameId.is_a?Integer)
      
      rval =  YAML::load(@serverConnection.whosTurn(gameId, @username, @password))
      raise AccessDeniedException if rval == false

      assert(rval.is_a?(Player) || rval.nil?)

      return rval
    end

    def getPlayers(gameId)
      assert(gameId.is_a?Integer)
      
      rval =  YAML::load(@serverConnection.getPlayers(gameId, @username, @password))
      raise AccessDeniedException if rval == false
      
      rval
    end
    
    def getWinner(gameId)
      assert(gameId.is_a?Integer)
      
      rval =  YAML::load(@serverConnection.getWinner(gameId, @username, @password))
      raise AccessDeniedException if rval == false

      assert(rval.is_a?Player || rval.nil?)
      
      rval
    end
   
    
    ## ---- UI Info Commands ---- ##
    def getGameList
      rval =  YAML::load(@serverConnection.getGameList(@username, @password))
      
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Hash))}
      
      rval
    end

    def getLeaderboard
      rval = YAML::load(@serverConnection.getLeaderboard)

      #post-conditions
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Hash))}
      
      rval
    end
    
  end
end
