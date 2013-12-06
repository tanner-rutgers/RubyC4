require 'test/unit'
require_relative '../database.rb'

module Model
  class Server

	def initialize(portno)
		@db = Database.new
	end
    	def login(name,password)
      		#preconditions
      		assert(username.is_a?String)
      		assert(password.is_a?String)
		return @db.login(name,password)
    	end
	# returns an array of new String(usernames)
    	def get_users()
		@db.get_users
   	end

	# returns the board 
 	def get_board(gameId,name,password)
 		assert(gameId.is_a?Integer)
		rval @db.login(name,password) ? @db.get_game(gameId).board : nil
      		assert(rval.is_a?(Game) || rval.nil?)
		rval
	end

	# makes move on server, returns nothing
    	def makeMove(gameId, name, password, move)
      		assert(gameId.is_a?Integer)
      		assert(move.is_a?Integer)
      		assert(user.is_a?User)
		game_model = @db.login(name,password) ? @db.get_game(gameId) : nil
		game_model.makeMove(@db.get_player(name),move)
		@db.save_game(gameId,game_model) 
		return game_model
    	end

	#
    	def whosTurn(gameId,name,password)
      		assert(gameId.is_a?Integer)
		game_model = @db.login(name,password) ? @db.get_game(gameId) : nil?
      		return game_model.currentPlayersTurn
		assert(rval.is_a?User)
    	end

	def newGame(username,password,opponent)
		if @db.login(name,password)
			player1 = @db.get_player(username)
			player2 = @db.get_player(opponent)
			game = Model::Game.new(player1,player2)
			@db.new_game(game)
			return true
		end
		return nil
	end

    	def getGameList(name,password)
      		assert(user.is_a?User)
		
		return [:id = > id, opponent, turn, timeOfLastMove]  
      		assert(rval.is_a?Array)
      		rval.each{|element| assert(element.is_a?(Integer))}
    	end

    	def getLeaderboard

      		#post-conditions
      		assert(rval.is_a?Array)
      		rval.each{|element| assert(element.is_a?(Array) && element.size == 2)}
    	end

  end
end
