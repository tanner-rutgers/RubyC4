
def initialize()
	#load persistent settings
	@win = false
	@current_player_index = nil
	@current_screen_index = nil
	@players = Array.new
	@screens = Array.new
	@model = new Model
	
	play()
end

def play()
	#MAIN GAME CODE
end

def win?()
	return @win
end

def push()
	#push next screen, update @current_screen
end

def update_board(x, y, val)
	#board[x][y] = val
end

def update_setting(setting, val) 
	#settings should be a hash or enumerated array
end

def load_persistent()
	#load persistent settings
end

def save_persistent()
	#save persistent settings
end

def get_controller()
	return self
end


