require_relative "Model/server/client.rb"

#creates new player(username,password).  If this place doesnt exist in the data will create
#.  If does will check password
clientBob = Model::Client.new("Bob", "Smith") 
clientJoe = Model::Client.new("Joe", "Smith")

#create a start a new game.  Contacts server, which creates a new game in the database with Bob.
#In the GUI you will be shown a list of all know players on the server.
gameId = clientJoe.newGame("Bob")


#client contactss server and makes move
clientJoe.makeMove(gameId, 2)
clientBob.makeMove(gameId, 3)
clientJoe.makeMove(gameId, 4)
clientBob.makeMove(gameId, 3)
clientJoe.makeMove(gameId, 4)
clientBob.makeMove(gameId, 3)
clientJoe.makeMove(gameId, 4)
clientBob.makeMove(gameId, 3) #Bob wins

puts(gameId)  #int primary key in database
puts(clientBob.getBoard(gameId))  #get board from server
puts(clientBob.whosTurn(gameId))  #get whose turn it is from server
#puts(clientBob.getBoard(999))    #get board from game 999 ( doesnt exist as of now, double checking error is thrown)
puts(clientBob.getGameList)       #returns a list ofgames, forget syntax 
puts(clientBob.getLeaderboard)    #returns a leaderboard, which is a hash of (playername,win) i beleive ( double check)
