require 'yaml'

module Model
  class Settings < Test::Unit::TestCase

	  def initialize
		@enum = Hash.new do |hash,key| 
			return nil #returns nil if key is not valid
		end
		@enum[:difficulty]="Medium" #possible values "Easy", "Medium", "Hard"
		@enum[:player_name]="Player 1" #allow user to change with textbox
		@enum[:game_type]="Connect4"
	    # set other settings here. all other keys will return null

		read_file


	  end

	  #returns setting value for string setting
	  def get(setting)
		return @enum.fetch(:"#{setting}")
	  end

	  def set(setting, value)
		if @enum[:"#{setting}" != nil]
		  #todo: check value is valid
		  @enum[:"#{setting}"] = value
		end
	  end
	  
	  def read_file
		valid_difficulties = Array.new(["Easy", "Medium", "Hard"])
		valid_game_types = Array.new(["Connect4", "Otto&Toot"])

		settings=YAML::load_file "../../resources/settings.yml"

		valid_difficulties.each { |a| set("difficulty", a) if settings["difficulty"] == a}
	    valid_game_types.each { |b| set("game_type", b) if settings["game_type"] == b}
		
		if (!settings["player_name"].nil?)
			RubyC4Application.getGame.players[0].name = settings["player_name"]
		end
		

	  end

	  def write_file
		game = RubyC4Application.getGame
		
		settings = Hash.new
		settings["difficulty"]=get("difficulty")
		settings["game_type"]=get("game_type")
		settings["player_name"]=game.players[0].name
		settings["player1_colour"]=game.players[0].colour
		settings["player2_colour"]=game.players[1].colour
		
	  end
  end

end
