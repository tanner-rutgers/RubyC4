require 'test/unit'
require "yaml"
require_relative '../database.rb'
require_relative '../game.rb'
require_relative '../player.rb'
require_relative '../board.rb'

module Model
  class Server
    INTERFACE = XMLRPC::interface("server") do
      meth "string login(name,password)", ""
      meth "string get_users()", ""
      meth "string getBoard(gameId, name, password)", ""
      meth "string makeMove(gameId, name, password, move)", ""
      meth "string whosTurn(gameId,name,password)", ""
      meth "string newGame(name,password,opponent)", ""
      meth "string getGameList(name,password)", ""
      meth "string getLeaderboard()", ""
    end
    
    include Test::Unit::Assertions
    
    def initialize
      @db = Database.new
    end
    def login(name,password)
      #preconditions
      assert(name.is_a?String)
      assert(password.is_a?String)
      
      return YAML::dump(@db.login(name,password))
    end
    # returns an array of new String(usernames)
    def get_users()
      YAML::dump(@db.get_users)
    end

    # returns the board 
    def getBoard(gameId,name,password)
      assert(gameId.is_a?Integer)
      
      return YAML::dump(false) if !@db.login(name,password) || @db.get_game(gameId).nil?
      return YAML::dump(@db.get_game(gameId).board)
    end

    # makes move on server, returns nothing
    def makeMove(gameId, name, password, move)
      assert(gameId.is_a?Integer)
      assert(move.is_a?Integer)
      
      return YAML::dump(false) if !@db.login(name,password)
      
      game_model = @db.get_game(gameId)
      game_model.makeMove(@db.get_player(name),move)
      @db.save_game(gameId,game_model) 
      
      return YAML::dump(true)
    end

    #
    def whosTurn(gameId,name,password)
      assert(gameId.is_a?Integer)
      
      return YAML::dump(false) if !@db.login(name,password)
      
      game_model = @db.get_game(gameId)
      return YAML::dump(game_model.currentPlayersTurn)
    end

    def newGame(name,password,opponent)
      return YAML::dump(false) if !@db.login(name,password)
      
      player1 = @db.get_player(name)
      player2 = @db.get_player(opponent)
      game = Model::Game.new(player1,player2)
      gameId = @db.new_game(game)
      
      return YAML::dump(gameId)
    end

    def getGameList(name,password)      
      return YAML::dump(false) if !@db.login(name,password)
      return YAML::dump(@db.getGameList(@db.get_id(name)))
    end

    def getLeaderboard
	return YAML::dump(@db.get_leaderboard)
    end

  end
end
