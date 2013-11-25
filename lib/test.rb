require_relative 'Model/win_condition.rb'
require_relative 'Model/player.rb'
require_relative 'Model/board.rb'
require_relative 'Model/game.rb'
require_relative 'Model/ai.rb'
require_relative 'Model/colour.rb'
include Model
p1 = Model::Player.new("X",nil)
p2 = Model::AI.new("0",nil)
p2.opponent(p1)
players = [p1,p2]

game = Game.new(players)

puts game
while(!game.gameOver?)
	puts "enter input"
	r = gets
	game.makeMove(p1,r.to_i)
	puts game
	game.makeMove(p2,1) if !game.gameOver?
	puts game
end
puts game

