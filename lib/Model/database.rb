require "mysql"
require "yaml"
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
		deserialize(row[1]) unless row.nil?
	end

	def save_game(id, game_model)
		result = game_model.gameOver? ? get_id(game_model.winner.name) : "null"
		db_save_game(id, serialize(game_model), result)
	end	
	def db_save_game(id,game,result)

		@db.query("update games set game=\'#{game}\', result=\'#{result}\' where id=#{id}")
	end
	def serialize(s)
		YAML::dump(s)	
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
		YAML::load(s) unless s.nil?
	end
	def get_games(playerId = nil)
		return @db.query("select * from games") if playerId.nil?
		@db.query("select * from games where player1 = \'#{playerId}\' or player2 = \'#{playerId}\'")
		
	end

	def getGameList(playerId)
		results = @db.query("select * from games join players p on player1=p.id or player2 = p.id where (player1=#{playerId} or player2=#{playerId}) and p.id <> #{playerId}")
		arr = Array.new
		
		results.each_hash do |x| 
		  arr.push( {
		             :id => x["id"], 
		             :opponent => deserialize(x["player"]), 
		             :turn => deserialize(x["game"]).currentPlayersTurn, 
		             :timestamp => x["timestamp"]
		            }
		          )
		end
		
		return arr
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
		#return the id of the game we just created.
		return @db.insert_id
	end
	
	def get_leaderboard
	  results = @db.query("select p.name, count(*) as wins from games join players p on result=p.id group by p.name")
	  
	  arr = Array.new
	
	  results.each_hash do |x| 
	    arr.push( {
			:name => x["name"], 
			:wins => x["wins"]
		      }
		    )
	  end
	  
	  return arr
	  
	end
	
	def get_players(gameId)
	  results = @db.query("select player from games g join players p on player1 = p.id or player2 = p.id where g.id = #{gameId}")
	  
	  return [deserialize(results.fetch_row[0]),deserialize(results.fetch_row[0])] if results.num_rows == 2
	  return nil
	  
	end
	
	def get_winner(gameId)
	  results = @db.query("select player from games g join players p on result=p.id where g.id = #{gameId}")
	  
	  return deserialize(results.fetch_row[0]) unless results.num_rows == 0
	  
	end
end
