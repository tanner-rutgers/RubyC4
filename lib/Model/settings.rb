module Model
  class Settings < Test::Unit::TestCase

	  def initialize
		@enum = Hash.new do |hash,key| 
			return nil #returns nil if key is not valid
		end
		@enum[:difficulty]=1 #possible values 0, 1, 2
		@enum[:player_name]="Player 1" #allow user to change with textbox
		@enum[:game_type]="Connect4"
	    # set other settings here. all other keys will return null
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

	  end

	  def write_file

	  end
  end

end
