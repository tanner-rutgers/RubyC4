require 'test/unit'
require 'xmlrpc/client'
require 'yaml'
require_relative '../game.rb'
require_relative '../board.rb'
require_relative '../player.rb'

module Model
  class Client
    include Test::Unit::Assertions

    attr_reader :username
    class AccessDeniedException < StandardError;
    end   
    
      
    def initialize(username, password)
      #preconditions
      assert(username.is_a?String)
      assert(password.is_a?String)
      
      @instance_lock = Mutex.new
      @username = username
      @password = password
      
      raise AccessDeniedException if !YAML::load(serverConnection.login(username, password))
      
      #preconditions
      assert_equal(@username, username)
      assert_equal(@password, password)
    end
    
    ## ---- Gameplay Commands ---- ##
    def newGame(opponentUsername, gameType)
      rval = YAML::load(serverConnection.newGame(@username, @password, opponentUsername, gameType))

      raise AccessDeniedException if rval == false
      return rval
    end   

    def makeMove(gameId, move)
      assert(gameId.is_a?Integer)
      assert(move.is_a?Integer)
      
      #Make move and raise exception if an credentials are bad.
      rval =  YAML::load(serverConnection.makeMove(gameId, @username, @password, move))
      raise AccessDeniedException if rval == false
	
    end
    
    def getBoard(gameId)
      assert(gameId.is_a?Integer)
            
      rval = YAML::load(serverConnection.getBoard(gameId, @username, @password))
      raise AccessDeniedException if rval == false
      
      return rval
    end

    def whosTurn(gameId)
      assert(gameId.is_a?Integer)
      
      rval =  YAML::load(serverConnection.whosTurn(gameId, @username, @password))
      raise AccessDeniedException if rval == false

      assert(rval.is_a?(Player) || rval.nil?)

      return rval
    end

    def getGameType(gameId)
      assert(gameId.is_a?Integer)
      
      rval =  YAML::load(serverConnection.getGameType(gameId, @username, @password))
      raise AccessDeniedException if rval == false
      assert(!rval.nil? && (rval == :connect4 || rval == :otto))

      return rval
    end
    
    def getPlayer
	rval = YAML::load(serverConnection.getPlayer(@username, @password))
	raise AccessDeniedException if rval == false
	
	return rval
    end

    def getPlayers(gameId)
      assert(gameId.is_a?Integer)
      rval =  YAML::load(serverConnection.getPlayers(gameId, @username, @password))
      raise AccessDeniedException if rval == false
      
      rval
    end
    
    def getWinner(gameId)
      assert(gameId.is_a?Integer)
      
      rval =  YAML::load(serverConnection.getWinner(gameId, @username, @password))
      raise AccessDeniedException if rval == false

      assert(rval.is_a?(Player) || rval.nil?)
      
      rval
    end
   
    
    ## ---- UI Info Commands ---- ##
    def getGameList
      rval =  YAML::load(serverConnection.getGameList(@username, @password))
      
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Hash))}
      
      rval
    end
    
    def getUserList
      rval =  YAML::load(serverConnection.get_users)
      raise AccessDeniedException if rval == false
      
      rval.delete_if {|element| element == @username}
      
      rval
    end

    def getLeaderboard
      rval = YAML::load(serverConnection.getLeaderboard)

      #post-conditions
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Hash))}
      
      rval
    end
    
    def serverConnection
      @instance_lock.synchronize do
        @server = XMLRPC::Client.new("localhost","/RPC2", 50500).proxy("server") if @server.nil?
        
        begin
	        @server.login(@username, @password)
        rescue Errno::EPIPE => e
	        puts "Restarting server connection"
	        @server = XMLRPC::Client.new("localhost","/RPC2", 50500).proxy("server") if @server.nil?
        end
      end
      
      return @server
    end
    
  end
end
