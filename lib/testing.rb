require_relative "Model/server/client.rb"


clientBob = Model::Client.new("Bob", "Smith")
clientJoe = Model::Client.new("Joe", "Smith")

gameId = clientJoe.newGame("Bob")

clientJoe.makeMove(gameId, 2)
clientBob.makeMove(gameId, 3)
clientJoe.makeMove(gameId, 4)
clientBob.makeMove(gameId, 3)
clientJoe.makeMove(gameId, 4)
clientBob.makeMove(gameId, 3)
clientJoe.makeMove(gameId, 4)
clientBob.makeMove(gameId, 3)

puts(gameId)
puts(clientBob.getBoard(gameId))
puts(clientBob.whosTurn(gameId))
#puts(clientBob.getBoard(999))
puts(clientBob.getGameList)
puts(clientBob.getLeaderboard)