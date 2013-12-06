require "mysql"
require "json"
require_relative "player.rb"

class Database
	def initialize()
		@db = Mysql.new("mysqlsrv.ece.ualberta.ca", "group2", "qypMR1DcpIzv", "group2",13010)
	end
	def query(s)
		@db.query(s)
	end

	# -- if username exists returns true if password is correct
	# -- if username exists returns false if password is incorrect
	# -- if username does not exist creates a new user with name and password and returns true
	def login(name,password)
		result = @db.query("select * from players where name = \'#{name}\' and password = \'#{password}\'")
		
		if(result.num_rows == 1)
			return true
		else
			result = @db.query("select * from players where name = \'#{name}\'")	
			return false if result.num_rows == 1
			insert_user(name,password)
			return true
		end
		result.fetch_row #returns array of (playerid,name,password)
	end
	def insert_user(name,password)
		player = serialize(Model::Player.new(name))
		@db.query("insert into players (name,password,player) values (\'#{name}\',\'#{password}\',\'#{player}\')")
	end
	def get_game(id)
		row = @db.query("select * from games where id = #{id}").fetch_row
		unserialize(row[1])
	end

	def save_game(id, game_model)
		players = [game_model.players[0],game_model.players[1].id]
		result = game_model.gameOver? ? game_model.winner.id : "null"
		game = "test"
		db_save_game(id,game,players,result)
	end	
	def db_save_game(id,game,players,result)

		@db.query("replace into games (id,game,player1,player2,result) values (#{id},\'#{game}\',#{players[0]},#{players[1]},#{result})")
	end
	def serialize(s)
		Marshal.dump(s)	
	end
	def get_users
		result = @db.query("select name from players")
        	arr = Array.new
	        while(!(row = result.fetch_row).nil?)
        	        arr.push(row[0])
	        end
        	arr
	end
	def deserialize(s)
		Marshal.load(s)
	end
	def get_games(playerId = nil)
		return @db.query("select * from games") if playerId.nil?
		@db.query("select * from games where player1 = \'#{playerId}\' or player2 = \'#{playerId}\'")
		
	end

	def getGameList(playerId)
		results = @db.query("select * from games join players p on player1=p.id or player2 = p.id where (player1=#{playerId} or player2=#{playerId}) and p.id <> #{playerId}")
		arr = Array.new
		results.each_hash{ |x| arr.push( {:id => x[:id], :opponent => x[:player], :turn => deserialize(x[:game]).currentPlayersTurn, :timestamp => x[:timestamp]})}
	end
		
	def get_timestamp(id)
		result = @db.query("select timestamp from games where id = \'#{id}\'")
		return result.fetch_row[0]
	end
	# returns a player object
	def get_player(name)
		result = @db.query("select player from players where name = \'#{name}\'")
		return deserialize(result.fetch_row[0]) if result.num_rows > 0
		return nil
	end
	def get_id(name)
		result = @db.query("select id from players where name = \'#{name}\'")
		result.fetch_row[0] if result.num_rows == 1		
	end
	def new_game(game)
		player1Id = get_id(game.players[0].name)
		player2Id = get_id(game.players[1].name)
		@db.query("insert into games (game,player1,player2) values (\'#{serialize(game)}\',#{player1Id},#{player2Id})")	
	end
end
