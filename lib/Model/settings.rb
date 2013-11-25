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

		#read_file()
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

		settings=YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../../resources/settings.yml')) 

		valid_difficulties.each do |a|
            set("difficulty", a) if settings["difficulty"] == a
        end
	    valid_game_types.each do |b|
            set("game_type", b) if settings["game_type"] == b
        end


		game = RubyC4Application.getGame
		if (!settings["player_name"].nil?)

			game.players[0].name = settings["player_name"]
		end

		#todo: check valid color before setting
		if (!settings["player1_colour"].nil?)
			game.players[0].colour = settings["player1_colour"]
		end
		if (!settings["player2_colour"].nil?)
			game.players[1].colour = settings["player2_colour"]
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

		File.open("../../resources/settings.yml", "w") do |file|
  			file.write settings.to_yaml
		end		
	  end
  end

end
