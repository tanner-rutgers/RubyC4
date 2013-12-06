require "mysql"
require "json"

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
		@db.query("insert into players (name,password) values (\'#{name}\',\'#{password}\')")
	end
	def get_game(id)
		row = @db.query("select * from games where id = #{id}").fetch_row
		unserialize(row[1])
	end

	def save_game(game_model)
		raise NoMethodError # function not working yet
		players = game_model.players
		id = game_model.id
		result = game_model.game_over ? game_model.winner.id : nil
		game = serialize(game_model)
		db_save_game(id,game,players,result)
	end	
	def db_save_game(id,game,players,result)
		@db.query("replace into games (id,game,player1,player2,result) values (#{id},\'#{game}\',#{players[0]},#{players[1]},#{result})")
	end
	def serialize(game)
		game.to_json
	end
	def unserialize(s)
		JSON::parse(s)
	end
	def get_games(id = nil)
		return @db.query("select * from games") if id.nil?
		@db.query("select * from games where player1 = \'#{id}\' or player2 = \'#{id}\'")
	end
end
